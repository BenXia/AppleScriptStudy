FasdUAS 1.101.10   ��   ��    k             l     ��  ��    < 6---- Demo --------------------------------------------     � 	 	 l - - - -   D e m o   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   
  
 l     ��������  ��  ��        l     ��  ��      Begin showing ScriptView     �   2   B e g i n   s h o w i n g   S c r i p t V i e w      l     ����  I     �������� "0 startscriptview startScriptView��  ��  ��  ��        l     ��������  ��  ��        l     ��  ��    &   Add lines of text to ScriptView     �   @   A d d   l i n e s   o f   t e x t   t o   S c r i p t V i e w      l   ) ����  Y    ) ��   ��  k    $ ! !  " # " r     $ % $ b     & ' & b     ( ) ( m     * * � + + 4 Y o u r   s c r i p t   h a s   c o m p l e t e d   ) o    ���� 0 i   ' m     , , � - -  / 5 0   t a s k s . % o      ���� 0 newline newLine #  . / . I    �� 0���� $0 appendscriptview appendScriptView 0  1�� 1 o    ���� 0 newline newLine��  ��   /  2�� 2 I   $�� 3��
�� .sysodelanull��� ��� nmbr 3 m      4 4 ?���������  ��  �� 0 i    m   	 
����    m   
 ���� 2��  ��  ��     5 6 5 l     ��������  ��  ��   6  7 8 7 l     �� 9 :��   9   Quit showing ScriptView    : � ; ; 0   Q u i t   s h o w i n g   S c r i p t V i e w 8  < = < l  * 0 >���� > I   * 0�� ?���� *0 endscriptviewasking endScriptViewAsking ?  @�� @ m   + ,��
�� boovtrue��  ��  ��  ��   =  A B A l     ��������  ��  ��   B  C D C l     ��������  ��  ��   D  E F E l     �� G H��   G 7 1------ Reuseable Handlers for ScriptView --------    H � I I b - - - - - -   R e u s e a b l e   H a n d l e r s   f o r   S c r i p t V i e w   - - - - - - - - F  J K J l     ��������  ��  ��   K  L M L i      N O N I      �������� "0 startscriptview startScriptView��  ��   O k     ; P P  Q R Q l     �� S T��   SXR The usual ways to "launch" or "run" an application from AppleScript didn't work for me, possibly because ScriptView.app is a "background-only" app (that is, LSUIElement), which means that it does not show in the menu bar, ?tab application switcher or dock.  Anyhow, after about an hour of trial and error I found that this seems to work�    T � U U�   T h e   u s u a l   w a y s   t o   " l a u n c h "   o r   " r u n "   a n   a p p l i c a t i o n   f r o m   A p p l e S c r i p t   d i d n ' t   w o r k   f o r   m e ,   p o s s i b l y   b e c a u s e   S c r i p t V i e w . a p p   i s   a   " b a c k g r o u n d - o n l y "   a p p   ( t h a t   i s ,   L S U I E l e m e n t ) ,   w h i c h   m e a n s   t h a t   i t   d o e s   n o t   s h o w   i n   t h e   m e n u   b a r ,  # t a b   a p p l i c a t i o n   s w i t c h e r   o r   d o c k .     A n y h o w ,   a f t e r   a b o u t   a n   h o u r   o f   t r i a l   a n d   e r r o r   I   f o u n d   t h a t   t h i s   s e e m s   t o   w o r k & R  V W V r      X Y X l    	 Z���� Z c     	 [ \ [ l     ]���� ] n      ^ _ ^ 1    ��
�� 
psxp _ l     `���� ` I    �� a��
�� .earsffdralis        afdr a  f     ��  ��  ��  ��  ��   \ m    ��
�� 
TEXT��  ��   Y o      ���� 0 pathtome pathToMe W  b c b r     d e d n     f g f 1    ��
�� 
strq g l    h���� h b     i j i o    ���� 0 pathtome pathToMe j m     k k � l l B C o n t e n t s / R e s o u r c e s / S c r i p t V i e w . a p p��  ��   e o      ����  0 scriptviewpath scriptViewPath c  m n m r     o p o b     q r q m     s s � t t 
 o p e n   r o    ����  0 scriptviewpath scriptViewPath p o      ���� 0 cmd   n  u v u r    ! w x w I   �� y��
�� .sysoexecTEXT���     TEXT y o    ���� 0 cmd  ��   x o      ���� 0 ls   v  z { z l  " "�� | }��   | � � You probably want your script to be the active application, and ScriptView to be directly under it.  The following two lines do that    } � ~ ~
   Y o u   p r o b a b l y   w a n t   y o u r   s c r i p t   t o   b e   t h e   a c t i v e   a p p l i c a t i o n ,   a n d   S c r i p t V i e w   t o   b e   d i r e c t l y   u n d e r   i t .     T h e   f o l l o w i n g   t w o   l i n e s   d o   t h a t {   �  O  " 0 � � � I  * /������
�� .miscactvnull��� ��� null��  ��   � 5   " '�� ���
�� 
capp � m   $ % � � � � � 6 c o m . s h e e p s y s t e m s . S c r i p t V i e w
�� kfrmID   �  ��� � O  1 ; � � � I  5 :������
�� .miscactvnull��� ��� null��  ��   �  f   1 2��   M  � � � l     ��������  ��  ��   �  � � � i     � � � I      �� ����� $0 appendscriptview appendScriptView �  ��� � o      ���� 0 aline aLine��  ��   � O     � � � I   �� ���
�� .ScpVAdLnnull���     ctxt � o    	���� 0 aline aLine��   � 5     �� ���
�� 
capp � m     � � � � � 6 c o m . s h e e p s y s t e m s . S c r i p t V i e w
�� kfrmID   �  � � � l     ��������  ��  ��   �  � � � i     � � � I      �� ����� *0 endscriptviewasking endScriptViewAsking �  ��� � o      ���� 0 doask doAsk��  ��   � Z     D � ����� � l     ����� � I     �� ����� $0 isappnamerunning isAppNameRunning �  ��� � m     � � � � �  S c r i p t V i e w��  ��  ��  ��   � k   	 @ � �  � � � Z   	 % � ����� � l  	 
 ����� � o   	 
���� 0 doask doAsk��  ��   � k    ! � �  � � � O    � � � I   ������
�� .miscactvnull��� ��� null��  ��   �  f     �  ��� � I   !�� � �
�� .sysodlogaskr        TEXT � m     � � � � � T C l i c k   ' O K '   t o   c l o s e   t h e   S c r i p t   L o g   w i n d o w . � �� ���
�� 
btns � J     � �  ��� � m     � � � � �  O K��  ��  ��  ��  ��   �  � � � l  & &��������  ��  ��   �  � � � l  & &� � ��   � d ^ In case user has already closed the ScriptView window, which will cause it to quit, we 'try'�    � � � � �   I n   c a s e   u s e r   h a s   a l r e a d y   c l o s e d   t h e   S c r i p t V i e w   w i n d o w ,   w h i c h   w i l l   c a u s e   i t   t o   q u i t ,   w e   ' t r y ' & �  ��~ � Q   & @ � ��} � O  ) 7 � � � I  1 6�|�{�z
�| .aevtquitnull��� ��� null�{  �z   � 5   ) .�y ��x
�y 
capp � m   + , � � � � � 6 c o m . s h e e p s y s t e m s . S c r i p t V i e w
�x kfrmID   � R      �w�v�u
�w .ascrerr ****      � ****�v  �u  �}  �~  ��  ��   �  � � � l     �t�s�r�t  �s  �r   �  � � � i     � � � I      �q ��p�q $0 isappnamerunning isAppNameRunning �  ��o � o      �n�n 0 targetappname targetAppName�o  �p   � k     O � �  � � � r      � � � m     �m
�m 
msng � o      �l�l  0 targetappalias targetAppAlias �  � � � O    L � � � k    K � �  � � � r     � � � n     � � � 1    �k
�k 
appf � 2    �j
�j 
pcap � o      �i�i &0 runningappaliases runningAppAliases �  � � � l   �h�g�f�h  �g  �f   �  ��e � X    K ��d � � Q     F � ��c � Z   # = � ��b�a � >  # & � � � o   # $�`�` 0 appalias appAlias � m   $ %�_
�_ 
msng � Z   ) 9 � ��^�] � =  ) 0 � � � n   ) , � � � 1   * ,�\
�\ 
pnam � o   ) *�[�[ 0 appalias appAlias � l  , / ��Z�Y � b   , / � � � o   , -�X�X 0 targetappname targetAppName � m   - . � � � � �  . a p p�Z  �Y   � L   3 5 � � m   3 4�W
�W boovtrue�^  �]  �b  �a   � R      �V�U�T
�V .ascrerr ****      � ****�U  �T  �c  �d 0 appalias appAlias � o    �S�S &0 runningappaliases runningAppAliases�e   � m     � ��                                                                                  sevs  alis    �  Air2-1                     �Ȗ�H+   Ym�System Events.app                                               \�%���e        ����  	                CoreServices    ���*      ����     Ym� Ym� Ym�  7Air2-1:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    A i r 2 - 1  -System/Library/CoreServices/System Events.app   / ��   �  � � � l  M M�R�Q�P�R  �Q  �P   �  ��O � L   M O � � m   M N�N
�N boovfals�O   �  � � � l     �M�L�K�M  �L  �K   �    l     �J�J   7 1------ end Reuseable Handlers for ScriptView ----    � b - - - - - -   e n d   R e u s e a b l e   H a n d l e r s   f o r   S c r i p t V i e w   - - - - �I l     �H�G�F�H  �G  �F  �I       �E	
�D�C�B�A�E   
�@�?�>�=�<�;�:�9�8�7�@ "0 startscriptview startScriptView�? $0 appendscriptview appendScriptView�> *0 endscriptviewasking endScriptViewAsking�= $0 isappnamerunning isAppNameRunning
�< .aevtoappnull  �   � ****�; 0 newline newLine�:  �9  �8  �7   �6 O�5�4�3�6 "0 startscriptview startScriptView�5  �4   �2�1�0�/�2 0 pathtome pathToMe�1  0 scriptviewpath scriptViewPath�0 0 cmd  �/ 0 ls   �.�-�, k�+ s�*�) ��(�'
�. .earsffdralis        afdr
�- 
psxp
�, 
TEXT
�+ 
strq
�* .sysoexecTEXT���     TEXT
�) 
capp
�( kfrmID  
�' .miscactvnull��� ��� null�3 <)j  �,�&E�O��%�,E�O�%E�O�j E�O)���0 *j 
UO) *j 
U �& ��%�$�#�& $0 appendscriptview appendScriptView�% �"�"   �!�! 0 aline aLine�$   � �  0 aline aLine � ���
� 
capp
� kfrmID  
� .ScpVAdLnnull���     ctxt�# )���0 �j U	 � ����� *0 endscriptviewasking endScriptViewAsking� ��   �� 0 doask doAsk�   �� 0 doask doAsk  ��� �� ��� ������ $0 isappnamerunning isAppNameRunning
� .miscactvnull��� ��� null
� 
btns
� .sysodlogaskr        TEXT
� 
capp
� kfrmID  
� .aevtquitnull��� ��� null�  �  � E*�k+  <� ) *j UO���kvl Y hO )���0 *j 
UW X  hY h
 � ���
�	� $0 isappnamerunning isAppNameRunning� ��   �� 0 targetappname targetAppName�
   ����� 0 targetappname targetAppName�  0 targetappalias targetAppAlias� &0 runningappaliases runningAppAliases� 0 appalias appAlias � ��� �������� �����
� 
msng
� 
pcap
�  
appf
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pnam��  ��  �	 P�E�O� E*�-�,E�O :�[��l kh  �� ��,��%  eY hY hW X 	 
h[OY��UOf ��������
�� .aevtoappnull  �   � **** k     0      <����  ��  ��   ���� 0 i   	���� * ,���� 4������ "0 startscriptview startScriptView�� 2�� 0 newline newLine�� $0 appendscriptview appendScriptView
�� .sysodelanull��� ��� nmbr�� *0 endscriptviewasking endScriptViewAsking�� 1*j+  O "k�kh  �%�%E�O*�k+ O�j [OY��O*ek+  � L Y o u r   s c r i p t   h a s   c o m p l e t e d   5 0 / 5 0   t a s k s .�D  �C  �B  �A   ascr  ��ޭ