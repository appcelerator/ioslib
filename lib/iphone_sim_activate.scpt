FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
Script to wait until the iPhone Simulator is responding to AppleScript,
and then tell it to activate (come to the foreground).

We don't just want to activate it without first waiting to see if it is
running, because another script has already launched it, so if we
just did an activate now, we could end up with two instances of
the iPhone Simulator.

Xcode 6 Usage: osascript iphone_sim_activate.scpt "iOS Simulator" "Disabled"
Xcode 6 Usage: osascript iphone_sim_activate.scpt "iOS Simulator" "Apple Watch - 38mm"
Xcode 6 Usage: osascript iphone_sim_activate.scpt "iOS Simulator" "Apple Watch - 42mm"
Xcode 7 Usage: osascript iphone_sim_activate.scpt "Simulator"
     � 	 	6 
 S c r i p t   t o   w a i t   u n t i l   t h e   i P h o n e   S i m u l a t o r   i s   r e s p o n d i n g   t o   A p p l e S c r i p t , 
 a n d   t h e n   t e l l   i t   t o   a c t i v a t e   ( c o m e   t o   t h e   f o r e g r o u n d ) . 
 
 W e   d o n ' t   j u s t   w a n t   t o   a c t i v a t e   i t   w i t h o u t   f i r s t   w a i t i n g   t o   s e e   i f   i t   i s 
 r u n n i n g ,   b e c a u s e   a n o t h e r   s c r i p t   h a s   a l r e a d y   l a u n c h e d   i t ,   s o   i f   w e 
 j u s t   d i d   a n   a c t i v a t e   n o w ,   w e   c o u l d   e n d   u p   w i t h   t w o   i n s t a n c e s   o f 
 t h e   i P h o n e   S i m u l a t o r . 
 
 X c o d e   6   U s a g e :   o s a s c r i p t   i p h o n e _ s i m _ a c t i v a t e . s c p t   " i O S   S i m u l a t o r "   " D i s a b l e d " 
 X c o d e   6   U s a g e :   o s a s c r i p t   i p h o n e _ s i m _ a c t i v a t e . s c p t   " i O S   S i m u l a t o r "   " A p p l e   W a t c h   -   3 8 m m " 
 X c o d e   6   U s a g e :   o s a s c r i p t   i p h o n e _ s i m _ a c t i v a t e . s c p t   " i O S   S i m u l a t o r "   " A p p l e   W a t c h   -   4 2 m m " 
 X c o d e   7   U s a g e :   o s a s c r i p t   i p h o n e _ s i m _ a c t i v a t e . s c p t   " S i m u l a t o r " 
   
  
 l     ��������  ��  ��        i         I     �� ��
�� .aevtoappnull  �   � ****  o      ���� 0 argv  ��    Z     �  ����  ?        l     ����  I    �� ��
�� .corecnte****       ****  o     ���� 0 argv  ��  ��  ��    m    ����    k   
 }       r   
     n   
     4    �� 
�� 
cobj  m    ����   o   
 ���� 0 argv    o      ���� 0 	simulator         l   ��������  ��  ��      !�� ! Z    } " #���� " =    $ % $ n     & ' & 1    ��
�� 
prun ' 4    �� (
�� 
capp ( o    ���� 0 	simulator   % m    ��
�� boovtrue # O    y ) * ) k   # x + +  , - , l  # #�� . /��   . !  focus the simulator window    / � 0 0 6   f o c u s   t h e   s i m u l a t o r   w i n d o w -  1 2 1 I  # (������
�� .miscactvnull��� ��� null��  ��   2  3 4 3 l  ) )��������  ��  ��   4  5 6 5 l  ) )�� 7 8��   7 J D if they specified a 2nd arg, then this must be the external display    8 � 9 9 �   i f   t h e y   s p e c i f i e d   a   2 n d   a r g ,   t h e n   t h i s   m u s t   b e   t h e   e x t e r n a l   d i s p l a y 6  : ; : l  ) )�� < =��   < G A this should only be passed in if it's an Xcode 6.x iOS Simulator    = � > > �   t h i s   s h o u l d   o n l y   b e   p a s s e d   i n   i f   i t ' s   a n   X c o d e   6 . x   i O S   S i m u l a t o r ;  ?�� ? Z   ) x @ A���� @ ?  ) 0 B C B l  ) . D���� D I  ) .�� E��
�� .corecnte****       **** E o   ) *���� 0 argv  ��  ��  ��   C m   . /����  A k   3 t F F  G H G r   3 9 I J I n   3 7 K L K 4   4 7�� M
�� 
cobj M m   5 6����  L o   3 4���� 0 argv   J o      ���� 0 ext_display   H  N�� N O   : t O P O O   > s Q R Q O   E r S T S k   O q U U  V W V I  O T������
�� .prcsclicnull��� ��� uiel��  ��   W  X�� X O   U q Y Z Y k   _ p [ [  \ ] \ I  _ d������
�� .prcsclicnull��� ��� uiel��  ��   ]  ^�� ^ I  e p�� _��
�� .prcsclicnull��� ��� uiel _ n   e l ` a ` 4   i l�� b
�� 
menI b o   j k���� 0 ext_display   a 4   e i�� c
�� 
menE c m   g h���� ��  ��   Z n   U \ d e d 4   Y \�� f
�� 
menI f m   Z [ g g � h h " E x t e r n a l   D i s p l a y s e 4   U Y�� i
�� 
menE i m   W X���� ��   T n   E L j k j 4   I L�� l
�� 
mbri l m   J K m m � n n  H a r d w a r e k 4   E I�� o
�� 
mbar o m   G H����  R 4   > B�� p
�� 
prcs p o   @ A���� 0 	simulator   P m   : ; q q�                                                                                  sevs  alis    �  Macintosh HD               �(2H+  �2?System Events.app                                              �L[�4�-        ����  	                CoreServices    �(��      �5"�    �2?�23�22  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��  ��  ��   * 4     �� r
�� 
capp r o    ���� 0 	simulator  ��  ��  ��  ��  ��     s�� s l     ��������  ��  ��  ��       �� t u v w����   t ��������
�� .aevtoappnull  �   � ****�� 0 	simulator  �� 0 ext_display  ��   u �� ���� x y��
�� .aevtoappnull  �   � ****�� 0 argv  ��   x ���� 0 argv   y �������������� q������ m������ g
�� .corecnte****       ****
�� 
cobj�� 0 	simulator  
�� 
capp
�� 
prun
�� .miscactvnull��� ��� null�� 0 ext_display  
�� 
prcs
�� 
mbar
�� 
mbri
�� .prcsclicnull��� ��� uiel
�� 
menE
�� 
menI�� ��j  j x��k/E�O*��/�,e  b*��/ W*j O�j  k F��l/E�O� 7*��/ /*�k/��/ $*j O*�k/��/ *j O*�k/��/j UUUUY hUY hY h v � z z  S i m u l a t o r w � { { $ A p p l e   W a t c h   -   4 2 m m��   ascr  ��ޭ