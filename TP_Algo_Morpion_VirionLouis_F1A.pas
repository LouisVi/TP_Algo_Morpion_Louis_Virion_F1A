{
ALGORITHME : Morpions
Une partie se déroule avec 2 joueurs, l'un choisi les croix l'autre les ronds. Le joueur qui commence est
choisi au hasard.


CONST
	MaxCell=3
	NbToursMax=9

Type
	RondCroix = (X,O)
	Victoire = (VictoireJ1,VictoireJ2)

Type Joueur = ENREGISTREMENT
		Symbole:RondCroix
		NbMancheGagnee:Entier
FIN ENREGISTREMENT

Type
	TabMorp=Tableau [1..3,1..3] de car
	TabJ=Tableau[1..2] de Joueur

procedure Initiatilisation(VAR Morp:TabMorp)

VAR
	i,j:entier

DEBUT //Revoir Initialisation
	POUR i DE 1 A MaxCell FAIRE
		POUR j DE 1 A MaxCell FAIRE
				Morp[i,j]<-" "
		FINPOUR
	FINPOUR
FIN

procedure Affichage(Morp:TabMorp)

VAR
	i,j:entier

DEBUT
	ECRIRE("MORPION : ")
	POUR i DE 1 A MaxCell FAIRE
		POUR j DE 1 A MaxCell FAIRE
			SI (j=MaxCell) ALORS
				ECRIRE(Morp[i,j])
			SINON
				ECRIRE(Morp[i,j],'|')
		FINPOUR
		ECRIRE() //Fonction saut de ligne
	FINPOUR
FIN

FONCTION JoueurChoix:ENTIER

VAR
	J:entier
	nb:entier

DEBUT
	// Fonction permettant de créer un aléatoire randomize
	nb<-random((2)+1)
	SI (nb=1) alors
		J<-1
	SINON
		J<-2
	FINSI

	JoueurChoix<-J
FIN

procedure JoueurCroixRond(VAR TabJoueur:TabJ;J:entier)

VAR
	RC,RC2:RondCroix
	i:entier

DEBUT
	REPETER
			ECRIRE("Taper 'X' ou 'O' pour choisir")
			LIRE(RC)
	JUSQU'A (RC=X) OU (RC=O)

	TabJoueur[J].Symbole<-RC
	
	SI RC=X alors
		RC2<-O
	SINON
		RC2<-X
	FINSI

	SI J=1 alors
		TabJoueur[2].Symbole<-RC2
	SINON
		TabJoueur[1].Symbole<-RC2
	FINSI

	POUR i DE 1 A 2 FAIRE
		ECRIRE('Le joueur ',i,' jouera avec les ',TabJoueur[i].Symbole)
	FINPOUR

FIN

FONCTION VideOk(L,C:Entier;Morp:TabMorp):boolean

DEBUT
	SI (Morp[L,C]<>' ') ALORS
		VideOk<-FAUX
	SINON
		VideOk<-VRAI
	FINSI
FIN

procedure Placement(VAR Morp:TabMorp;TabJoueur:TabJ;Joueur:Entier)

VAR
	PosChaine:chaine
	L,C:entier
	TestVide:booleen
	Symb:car

DEBUT
	REPETER
		ECRIRE("Veuillez placer votre symbole - Saisir de cette maniere (L/C)");
		LIRE(PosChaine);
		L<-StrToInt(Extraction(PosChaine,1,1)) //Appel d'une fonction de changement de type d'une chaine à un entier
		C<-StrToInt(Extraction(PosChaine,3,1))
		TestVide<-VideOk(L,C,Morp) // Fait appel à la fonction VideOk qui vérifie si la cellule du tableau est vide.
	JUSQU'A (TestVide=VRAI)	

	SI TestVide=VRAI ALORS
		SI TabJoueur[Joueur].Symbole=O ALORS
			Symb<-'O'
		SINON
			Symb<-'X'
		FINSI
		Morp[L,C]<-Symb
	FINSI
FIN	

procedure Alignement(Morp:TabMorp;TabJoueur:TabJ;VAR Vict:Victoire)

DEBUT
	SI ((Morp[1,1]='X') ET (Morp[1,2]='X') ET (Morp[1,3]='X')) OU ((Morp[2,1]='X') ET (Morp[2,2]='X') ET (Morp[2,3]='X'))
	OU ((Morp[3,1]='X') ET (Morp[3,2]='X') ET (Morp[3,3]='X')) OU ((Morp[1,1]='X') ET (Morp[2,1]='X') ET (Morp[3,1]='X'))
	OU ((Morp[1,2]='X') ET (Morp[2,2]='X') ET (Morp[3,2]='X')) OU ((Morp[1,3]='X') ET (Morp[2,3]='X') ET (Morp[3,3]='X'))
	OU ((Morp[1,1]='X') ET (Morp[2,2]='X') ET (Morp[3,3]='X')) OU ((Morp[3,1]='X') ET (Morp[2,2]='X') ET (Morp[1,3]='X'))
	ALORS
		SI TabJoueur[1].Symbole=X ALORS
			Vict<-VictoireJ1
		SINON
			Vict<-VictoireJ2
		FINSI
	FINSI

	SI ((Morp[1,1]='O') ET (Morp[1,2]='O') ET (Morp[1,3]='O')) OU ((Morp[2,1]='O') ET (Morp[2,2]='O') ET (Morp[2,3]='O'))
	OU ((Morp[3,1]='O') ET (Morp[3,2]='O') ET (Morp[3,3]='O')) OU ((Morp[1,1]='O') ET (Morp[2,1]='O') ET (Morp[3,1]='O'))
	OU ((Morp[1,2]='O') ET (Morp[2,2]='O') ET (Morp[3,2]='O')) OU ((Morp[1,3]='O') ET (Morp[2,3]='O') ET (Morp[3,3]='O'))
	OU ((Morp[1,1]='O') ET (Morp[2,2]='O') ET (Morp[3,3]='O')) OU ((Morp[3,1]='O') ET (Morp[2,2]='O') ET (Morp[1,3]='O'))
	ALORS
		SI TabJoueur[1].Symbole=O ALORS
			Vict<-VictoireJ1
		SINON
			Vict<-VictoireJ2
		FINSI
	FINSI
FIN

procedure TourDeJeu(VAR Morp:TabMorp;VAR J:entier;VAR TabJoueur:TabJ)

VAR
	i:entier
	PosChaine:chaine
	L,C:entier
	Vict:Victoire

DEBUT
	i<-0
	REPETER
		Clear // Appel de la fonction clrscr pour "nettoyer" l'écran
		i<-i+1
		Affichage(Morp)
		SI J=1 ALORS
			ECRIRE("Tour ",i," : Le joueur ",J," joue les ",TabJoueur[J].Symbole)
			Placement(Morp,TabJoueur,J)
			Affichage(Morp)
			Alignement(Morp,TabJoueur,Vict)
			J<-J+1
			Attendre// Appel de la fonction readln pour laisser l'affichage
		SINON
			ECRIRE("Tour ",i," : Le joueur ",J," joue les ",TabJoueur[J].Symbole)
			Placement(Morp,TabJoueur,J)
			Affichage(Morp)
			Alignement(Morp,TabJoueur,Vict)
			J<-J-1
			Attendre// Appel de la fonction readln pour laisser l'affichage
		FINSI
	JUSQU'A ((i=NbToursMax) OU (Vict=VictoireJ1) OU (Vict=VictoireJ2));

	SI (Vict=VictoireJ1) ALORS
		ECRIRE("Le joueur 1 a gagné !")
		TabJoueur[1].NbMancheGagnee:=TabJoueur[1].NbMancheGagnee+1
	FINSI

	SI (Vict=VictoireJ2) ALORS
		ECRIRE("Le joueur 2 a gagné !")
		TabJoueur[2].NbMancheGagnee:=TabJoueur[2].NbMancheGagnee+1
	FINSI

	SI ((i=NbToursMax) ET NON (Vict=VictoireJ1) ET NON (Vict=VictoireJ2)) ALORS
		ECRIRE("Egalité")

FIN

//Programme principal :

VAR
	Morp:TabMorp
	J:entier
	TabJoueur:TabJ
	manche:entier
	i,k:entier

DEBUT
	Clear // Appel de la fonction clrscr qui "nettoie" l'écran
	ECRIRE("Entrez le nombre de manches que vous voulez jouer")
	LIRE(manche)
	POUR i DE 1 A manche FAIRE
		Clear // Appel de la fonction clrscr qui "nettoie" l'écran
		Initiatilisation(Morp)
		Affichage(Morp)

		J:=JoueurChoix
		ECRIRE("Le joueur ",J," commence et choisit les X ou les O ")
		JoueurCroixRond(TabJoueur,J)

		Attendre //Appel de la fonction readln pour laisser l'affichage

		TourDeJeu(Morp,J,TabJoueur)
	FINPOUR

	ECRIRE("Nombre de manche(s) gagnée(s)"))
	
	POUR k DE 1 A 2 FAIRE
			ECRIRE("Joueur ",k," : "TabJoueur[k].NbMancheGagnee)
	FINPOUR
	Attendre //Appel de la fonction readln pour laisser l'affichage
FIN
}

Program Morpion;

uses crt,sysutils;

CONST
	MaxCell=3;
	NbToursMax=9;

Type
	RondCroix = (X,O);
	Victoire = (VictoireJ1,VictoireJ2);

Type Joueur = RECORD
		Symbole:RondCroix;
		NbMancheGagnee:integer;
		Nom : string ;
END;

Type
	TabMorp=Array [1..MaxCell,1..MaxCell] of char;
	TabJ=Array[1..2] of Joueur;



Procedure Gestionfichier ( var T1 : TabJ ; var f : textfile ; var tabjoueur:TabJ );
	begin
		Assign(f,'text.txt');
		Rewrite(f);
		If (IOResult <> 0) Then
			 writeln('Le fichier n''existe pas');
		close(f);
		append (f) ;
		writeln (f,'l''heure de la partie etait',timetostr(Time));
		writeln (f,'Joueur ',T1[1].nom,' : ',TabJoueur[1].NbMancheGagnee);
		writeln (f,'Joueur ',T1[2].nom,' : ',TabJoueur[2].NbMancheGagnee);
		if TabJoueur[1].NbMancheGagnee > TabJoueur[2].NbMancheGagnee then 
			writeln (f,'Le Joueur',T1[1].nom,'a gagner la partie')
		else if TabJoueur[1].NbMancheGagnee < TabJoueur[2].NbMancheGagnee then 
			writeln (f,'Le Joueur',T1[2].nom,'a gagner la partie')
		else 
			writeln (f,'Egalite') ;
	close (f) ;
	end ;

procedure Initiatilisation(VAR Morp:TabMorp); //Initialise le tableau du morpion qui contiendra soit les X soit les O

VAR
	i,j:integer;

BEGIN
	for i:=1 to MaxCell do
		BEGIN
			for j:=1 to MaxCell do
				BEGIN
					Morp[i,j]:=' ';
				END;
		END;

END;

procedure Affichage(Morp:TabMorp);
// Fonction d'affichage du tableau contenant les X et les O

VAR
	i,j:integer;

BEGIN
	writeln('MORPION :');
	for i:=1 to MaxCell do
		BEGIN
			for j:=1 to MaxCell do
				BEGIN
					if (j=MaxCell) then
						write(Morp[i,j])
					else
						write(Morp[i,j],'|');
				END;
			writeln;	
		END;
END;

Procedure Nomjoueur ( var T1:TabJ) ;
	var
	i : integer ;
	begin

		for i := 1 to 2 do
		begin
				writeln ('Entrez votre pseudo ') ;
				readln (T1[i].nom) ;
		end ;
	end;



function JoueurChoix ( var T1:TabJ):integer ;
VAR
	J:integer;
	nb:integer;
BEGIN
	randomize;
	nb:=random((2)+1);
	if (nb=1) then
		J:=1
	else
		J:=2;
	JoueurChoix:=J;
END;

procedure JoueurCroixRond(VAR TabJoueur:TabJ;J:integer);

VAR
	RC,RC2:RondCroix;
	i:integer;

BEGIN
	REPEAT
		begin
			writeln('X ou O pour choisir');
			readln(RC);
		end;
	UNTIL (RC=X) OR (RC=O) ;

	TabJoueur[J].Symbole:=RC;
	
	if RC=X then
		RC2:=O
	else
		RC2:=X;

	if J=1 then
		TabJoueur[2].Symbole:=RC2
	else
		TabJoueur[1].Symbole:=RC2;

	FOR i:=1 TO 2 DO
		begin
			writeln('Le joueur ',i,' a les ',TabJoueur[i].Symbole);
		end;
END;

function VideOk(L,C:integer;Morp:TabMorp):boolean;

BEGIN
	if (Morp[L,C]<>' ') then
		VideOk:=FALSE
	else
		VideOk:=TRUE;
END;

procedure Placement(VAR Morp:TabMorp;TabJoueur:TabJ;Joueur:integer);

VAR
	PosChaine:string;
	L,C:integer;
	TestVide:boolean;
	Symb:char;

BEGIN
	REPEAT
		writeln('Veuillez placer votre symbole - saisissez (Ligne/Colonne)');
		readln(PosChaine);
		L:=StrToInt(copy(PosChaine,1,1));
		C:=StrToInt(copy(PosChaine,3,1));
		TestVide:=VideOk(L,C,Morp); // Fait appel à la fonction VideOk qui vérifie si la cellule du tableau est vide.
	UNTIL (TestVide=TRUE);	

	if TestVide=TRUE then //Si le test est vrai alors on insère le symbole correspondant au joueur
		begin
			if TabJoueur[Joueur].Symbole=O then
				Symb:='O'
			else
				Symb:='X';
			Morp[L,C]:=Symb;
		end;
END;			

procedure Alignement(Morp:TabMorp;TabJoueur:TabJ;VAR Vict:Victoire);
//Vérification de l'alignement de 3 symboles identiques
BEGIN
	if ((Morp[1,1]='X') AND (Morp[1,2]='X') AND (Morp[1,3]='X')) OR ((Morp[2,1]='X') AND (Morp[2,2]='X') AND (Morp[2,3]='X'))
	OR ((Morp[3,1]='X') AND (Morp[3,2]='X') AND (Morp[3,3]='X')) OR ((Morp[1,1]='X') AND (Morp[2,1]='X') AND (Morp[3,1]='X'))
	OR ((Morp[1,2]='X') AND (Morp[2,2]='X') AND (Morp[3,2]='X')) OR ((Morp[1,3]='X') AND (Morp[2,3]='X') AND (Morp[3,3]='X'))
	OR ((Morp[1,1]='X') AND (Morp[2,2]='X') AND (Morp[3,3]='X')) OR ((Morp[3,1]='X') AND (Morp[2,2]='X') AND (Morp[1,3]='X'))
	then
		if TabJoueur[1].Symbole=X then
			Vict:=VictoireJ1
		else
			Vict:=VictoireJ2;

	if ((Morp[1,1]='O') AND (Morp[1,2]='O') AND (Morp[1,3]='O')) OR ((Morp[2,1]='O') AND (Morp[2,2]='O') AND (Morp[2,3]='O'))
	OR ((Morp[3,1]='O') AND (Morp[3,2]='O') AND (Morp[3,3]='O')) OR ((Morp[1,1]='O') AND (Morp[2,1]='O') AND (Morp[3,1]='O'))
	OR ((Morp[1,2]='O') AND (Morp[2,2]='O') AND (Morp[3,2]='O')) OR ((Morp[1,3]='O') AND (Morp[2,3]='O') AND (Morp[3,3]='O'))
	OR ((Morp[1,1]='O') AND (Morp[2,2]='O') AND (Morp[3,3]='O')) OR ((Morp[3,1]='O') AND (Morp[2,2]='O') AND (Morp[1,3]='O'))
	then
		if TabJoueur[1].Symbole=O then
			Vict:=VictoireJ1
		else
			Vict:=VictoireJ2;

  END;

procedure TourDeJeu(VAR Morp:TabMorp;VAR J:integer;VAR TabJoueur:TabJ ; Var T1 :TabJ);
VAR
	i:integer;
	PosChaine:string;
	L,C:integer;
	Vict:Victoire;

BEGIN
	i:=0;
	REPEAT
		begin
			clrscr;
			i:=i+1;
			Affichage(Morp);
			if J=1 then
				begin
					writeln('Tour num ',i,' : Le joueur ',T1[J].nom,' joue avec les ',TabJoueur[J].Symbole);
					Placement(Morp,TabJoueur,J);
					Affichage(Morp);
					Alignement(Morp,TabJoueur,Vict);
					J:=J+1;
					readln;
				end
			else
				BEGIN
					writeln('Tour ',i,' : Le joueur ',T1[J].nom,' joue les ',TabJoueur[J].Symbole);
					Placement(Morp,TabJoueur,J);
					Affichage(Morp);
					Alignement(Morp,TabJoueur,Vict);
					J:=J-1;
					readln;
				end;
		end;
	UNTIL ((i=NbToursMax) OR (Vict=VictoireJ1) OR (Vict=VictoireJ2)); // Vérifie le nombre de tour ou s'il y a victoire d'un joueur

	if Vict=VictoireJ1 then
		begin
			writeln(UTF8ToAnsi('Le joueur 1 gagne la partie !'));
			TabJoueur[1].NbMancheGagnee:=TabJoueur[1].NbMancheGagnee+1;
		end;

	if Vict=VictoireJ2 then
		begin
			writeln(UTF8ToAnsi('Le joueur 2 gagne la partie !'));
			TabJoueur[2].NbMancheGagnee:=TabJoueur[2].NbMancheGagnee+1;
		end;

	if ((i=NbToursMax) AND NOT (Vict=VictoireJ1) AND NOT (Vict=VictoireJ2)) then
		writeln('Egalité');

END;
VAR
	Morp:TabMorp;
	J:integer;
	TabJoueur:TabJ;
	manche:integer;
	i,k:integer;
	T1 : TabJ ;
	f:textfile ;

BEGIN
	clrscr;
	writeln('Entrez le nombre de manches que vous voulez jouer');
	readln(manche);
	Nomjoueur(T1) ;
	FOR i:=1 TO manche DO
		begin
			clrscr;
			Initiatilisation(Morp); //Appel de la procédure initialisation
			Affichage(Morp); //Appel de la procédure affichage
			J:=JoueurChoix(T1); //Appel de la fonction JoueurChoix
			writeln('Le Joueur ',T1[i].Nom,' commence et choisit les X ou les O ');

			JoueurCroixRond(TabJoueur,J); //Appel de la procédure choix rond ou croix
			readln;

			TourDeJeu(Morp,J,TabJoueur,T1); //Appel de la procédure tourdejeu
		end;
	writeln(UTF8ToAnsi('Nombre de manche(s) gagnée(s)'));
	FOR k:=1 to 2 DO
		begin
			writeln('Joueur ',T1[k].nom,' : ',TabJoueur[k].NbMancheGagnee);
		end;
		Gestionfichier(T1,f,TabJoueur) ;
	readln;
END.
