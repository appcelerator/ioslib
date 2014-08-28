/**
 * Tests ioslib's device module.
 *
 * @copyright
 * Copyright (c) 2014 by Appcelerator, Inc. All Rights Reserved.
 *
 * @license
 * Licensed under the terms of the Apache Public License.
 * Please see the LICENSE included with this distribution for details.
 */

const
	appc = require('node-appc'),
	exec = require('child_process').exec,
	fs = require('fs'),
	ioslib = require('..'),
	path = require('path');

function build(provisioningProfileUUID, certName, defs, done){
	if (typeof defs === 'function') {
		done = defs;
		defs = [];
	}

	ioslib.xcode.detect(function (err, env) {
		if (err) {
			return done(err);
		}

		if (env.selectedXcode === null) {
			return done(new Error(__('No selected Xcode')));
		}

		var cmd = [
			env.selectedXcode.executables.xcodebuild,
			'clean', 'build',
			'-configuration', 'Debug',
			'-sdk', 'iphoneos' + appc.version.format(env.selectedXcode.sdks[0], 2, 2),
			'VALID_ARCHS="armv7 armv7s"',
			'ARCHS="armv7 armv7s"',
			'IPHONEOS_DEPLOYMENT_TARGET=6.0',
			'PROVISIONING_PROFILE=' + provisioningProfileUUID,
			'DEPLOYMENT_POSTPROCESSING=YES',
			'CODE_SIGN_IDENTITY="' + certName + '"',
			'GCC_PREPROCESSOR_DEFINITIONS="' + defs.join(' ') + '"'
		].join(' ');

		exec(cmd, {
			cwd: path.join(__dirname, 'TestApp')
		}, function (code, out, err) {
			should(out).match(/BUILD SUCCEEDED/);
			var appPath = path.join(__dirname, 'TestApp', 'build', 'Debug-iphoneos', 'TestApp.app');
			should(fs.existsSync(appPath)).be.true;
			done(null, appPath);
		});
	});
}

describe('device', function () {
	it('namespace should be an object', function () {
		should(ioslib.device).be.an.Object;
	});

	it('detect iOS devices', function (done) {
		this.timeout(5000);
		this.slow(2000);

		ioslib.device.detect(function (err, results) {
			if (err) {
				return done(err);
			}

			should(results).be.an.Object;
			should(results).have.keys('devices', 'issues');

			should(results.devices).be.an.Array;
			results.devices.forEach(function (dev) {
				should(dev).be.an.Object;
				should(dev).have.keys('udid', 'name', 'buildVersion', 'cpuArchitecture', 'deviceClass', 'deviceColor',
					'hardwareModel', 'modelNumber', 'productType', 'productVersion', 'serialNumber');

				should(dev.udid).be.a.String;
				should(dev.udid).not.equal('');

				should(dev.name).be.a.String;
				should(dev.name).not.equal('');

				should(dev.buildVersion).be.a.String;
				should(dev.buildVersion).not.equal('');

				should(dev.cpuArchitecture).be.a.String;
				should(dev.cpuArchitecture).not.equal('');

				should(dev.deviceClass).be.a.String;
				should(dev.deviceClass).not.equal('');

				should(dev.deviceColor).be.a.String;
				should(dev.deviceColor).not.equal('');

				should(dev.hardwareModel).be.a.String;
				should(dev.hardwareModel).not.equal('');

				should(dev.modelNumber).be.a.String;
				should(dev.modelNumber).not.equal('');

				should(dev.productType).be.a.String;
				should(dev.productType).not.equal('');

				should(dev.productVersion).be.a.String;
				should(dev.productVersion).not.equal('');

				should(dev.serialNumber).be.a.String;
				should(dev.serialNumber).not.equal('');
			});

			should(results.issues).be.an.Array;
			results.issues.forEach(function (issue) {
				should(issue).be.an.Object;
				should(issue).have.keys('id', 'type', 'message');
				should(issue.id).be.a.String;
				should(issue.type).be.a.String;
				should(issue.type).match(/^info|warning|error$/);
				should(issue.message).be.a.String;
			});

			done();
		});
	});

	(process.env.TRAVIS ? it.skip : it)('should fail to install app bad app path', function (done) {
		this.timeout(30000);
		this.slow(30000);

		ioslib.device.install(null, '/path/to/something/that/does/not/exist', 'foo', function (err) {
			should(err).be.an.instanceOf(Error);
			done();
		}).on('error', function (err) {
			should(err).be.an.instanceOf(Error);
		});
	});

	(process.env.TRAVIS ? it.skip : it)('should be able to install app to device', function (done) {
		this.timeout(60000);
		this.slow(60000);

		// find us a device
		ioslib.device.detect(function (err, deviceResults) {
			if (!deviceResults.devices.length) {
				// no devices connected
				return done(new Error('No iOS devices connected'));
			}

			// next find us some certs
			ioslib.certs.detect(function (err, certResults) {
				var certs = [];
				Object.keys(certResults.certs.keychains).forEach(function (keychain) {
					var types = certResults.certs.keychains[keychain];
					Object.keys(types).forEach(function (type) {
						certs = certs.concat(types[type]);
					});
				});

				if (!certs.length) {
					return done(new Error('No iOS certificates'));
				}

				// find us a provisioning profile
				ioslib.provisioning.find({
					appId: 'com.appcelerator.TestApp',
					certs: certs,
					devicesUDIDs: deviceResults.devices.map(function (device) { return device.udid; })
				}, function (err, profiles) {
					if (!profiles.length) {
						return done(new Error('No provisioning profiles found'));
					}

					var profile = profiles.shift(),
						deviceUDID = deviceResults.devices.filter(function (device) { return profile.devices.indexOf(device.udid) !== -1; }).shift().udid,
						certName = certs.filter(function (cert) {
							var prefix = cert.pem.replace(/^-----BEGIN CERTIFICATE-----\n/, '').substring(0, 60);
							return profile.certs.some(function (pc) {
								return pc.indexOf(prefix) === 0;
							});
						}).shift().name;

					build(profile.uuid, certName, ['TEST_BASIC_LOGGING'], function (err, appPath) {
						should(err).not.be.ok;
						should(appPath).be.a.String;
						should(fs.existsSync(appPath)).be.ok;

						var started = false,
							logCounter = 0;

						ioslib.device.install(deviceUDID, appPath, 'com.appcelerator.TestApp', function (err, results) {
							should(err).not.be.ok;
							should(results).be.an.Object;
							should(results).have.property(deviceUDID);
							should(results[deviceUDID]).be.an.Object;
							should(results[deviceUDID]).have.property('success', true);

							console.log('Please launch app. You have 20 seconds.');

							setTimeout(function () {
								if (started) {
									should(logCounter).be.greaterThan(0);
								}
								done();
							}, 20000);
						}).on('appStarted', function () {
							started = true;
						}).on('log', function (msg) {
							logCounter++;
						});
					});
				});
			});

		});
	});
});