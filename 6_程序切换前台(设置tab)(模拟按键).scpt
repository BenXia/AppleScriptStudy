FasdUAS 1.101.10   ��   ��    k             l     ����  I    �� ��
�� .ascrnoop****      � ****  m      	 	�                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��  ��     
  
 l     ��������  ��  ��        l     ��  ��    ' ! tell application "System Events"     �   B   t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "      l     ��  ��    2 ,	set frontmost of process "TextMate" to true     �   X 	 s e t   f r o n t m o s t   o f   p r o c e s s   " T e x t M a t e "   t o   t r u e      l     ��  ��    ' !	keystroke "2" using command down     �   B 	 k e y s t r o k e   " 2 "   u s i n g   c o m m a n d   d o w n      l     ��  ��     
	delay 0.2     �    	 d e l a y   0 . 2     !   l     ��������  ��  ��   !  " # " l     �� $ %��   $ . (	set frontmost of process "Mail" to true    % � & & P 	 s e t   f r o n t m o s t   o f   p r o c e s s   " M a i l "   t o   t r u e #  ' ( ' l     ��������  ��  ��   (  ) * ) l     �� + ,��   + 5 /   ģ�ⰴ����Ϣ����  keystroke enter/tab ֮���    , � - - H      j!b�c	�.m�`o��g	     k e y s t r o k e   e n t e r / t a b  NK|{v� *  . / . l     �� 0 1��   0  end tell    1 � 2 2  e n d   t e l l /  3 4 3 l     ��������  ��  ��   4  5 6 5 l     ��������  ��  ��   6  7 8 7 l      �� 9 :��   9��
-- to raiseWindow of "iTerm" for "2. bash"
tell the application "iTerm"
	activate
	
	set theWindow to the first item of ?
		(get the windows whose name is "2. bash")
	if index of theWindow is not 1 then
		set index of theWindow to 1
		
		set visible of theWindow to false
		set visible of theWindow to true
	end if
	
	tell theWindow
		set theTab to the first item of theWindow's tabs
		
		select theTab
		
		select the third session of theTab
	end tell
end tell
    : � ; ;� 
 - -   t o   r a i s e W i n d o w   o f   " i T e r m "   f o r   " 2 .   b a s h " 
 t e l l   t h e   a p p l i c a t i o n   " i T e r m " 
 	 a c t i v a t e 
 	 
 	 s e t   t h e W i n d o w   t o   t h e   f i r s t   i t e m   o f   � 
 	 	 ( g e t   t h e   w i n d o w s   w h o s e   n a m e   i s   " 2 .   b a s h " ) 
 	 i f   i n d e x   o f   t h e W i n d o w   i s   n o t   1   t h e n 
 	 	 s e t   i n d e x   o f   t h e W i n d o w   t o   1 
 	 	 
 	 	 s e t   v i s i b l e   o f   t h e W i n d o w   t o   f a l s e 
 	 	 s e t   v i s i b l e   o f   t h e W i n d o w   t o   t r u e 
 	 e n d   i f 
 	 
 	 t e l l   t h e W i n d o w 
 	 	 s e t   t h e T a b   t o   t h e   f i r s t   i t e m   o f   t h e W i n d o w ' s   t a b s 
 	 	 
 	 	 s e l e c t   t h e T a b 
 	 	 
 	 	 s e l e c t   t h e   t h i r d   s e s s i o n   o f   t h e T a b 
 	 e n d   t e l l 
 e n d   t e l l 
 8  < = < l     ��������  ��  ��   =  > ? > l     ��������  ��  ��   ?  @ A @ l      �� B C��   B�{
-- to raiseWindow2 of "iTerm" for "2. bash"
tell the application "iTerm"
	activate
	
	set theWindow to the first item of ?
		(get the windows whose name is "2. bash")
	if the index of theWindow is not 1 then
		set the index of theWindow to 2
		tell application "System Events" to ?
			tell application process "iTerm2" to ?
				keystroke "`" using command down
	end if
end tell
    C � D D� 
 - -   t o   r a i s e W i n d o w 2   o f   " i T e r m "   f o r   " 2 .   b a s h " 
 t e l l   t h e   a p p l i c a t i o n   " i T e r m " 
 	 a c t i v a t e 
 	 
 	 s e t   t h e W i n d o w   t o   t h e   f i r s t   i t e m   o f   � 
 	 	 ( g e t   t h e   w i n d o w s   w h o s e   n a m e   i s   " 2 .   b a s h " ) 
 	 i f   t h e   i n d e x   o f   t h e W i n d o w   i s   n o t   1   t h e n 
 	 	 s e t   t h e   i n d e x   o f   t h e W i n d o w   t o   2 
 	 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   � 
 	 	 	 t e l l   a p p l i c a t i o n   p r o c e s s   " i T e r m 2 "   t o   � 
 	 	 	 	 k e y s t r o k e   " ` "   u s i n g   c o m m a n d   d o w n 
 	 e n d   i f 
 e n d   t e l l 
 A  E F E l     ��������  ��  ��   F  G H G l     ��������  ��  ��   H  I�� I l     ��������  ��  ��  ��       �� J K��   J ��
�� .aevtoappnull  �   � **** K �� L���� M N��
�� .aevtoappnull  �   � **** L k      O O  ����  ��  ��   M   N  	��
�� .ascrnoop****      � ****�� �j  ascr  ��ޭ