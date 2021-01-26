with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with arbre_genealog; use arbre_genealog;
procedure test_arbre_genealog is

   arbre : arbre_genealogique.T_Arbre_Bin;
   informations_individu : individu_int.T_Informations;
   nom_individu : Unbounded_String;
   prenom_individu : Unbounded_String;
   ind_1 : individu_int.T_Individu;
begin
   Put_Line("Debut du test de arbre_genealog");


   ------------------------- Test de procedure creer(arbre : in out T_Arbre_Bin); -----------------------------------------------

   -- cas nominal
   nom_individu := To_Unbounded_String("CONTANDIN");
   prenom_individu := To_Unbounded_String("Fernandel");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   creer(arbre => arbre, informations_individu => informations_individu);
   pragma Assert(arbre_genealogique.taille(arbre => arbre) = 1);
   pragma Assert(individu_int.getIdentifiant(arbre_genealogique.getElement(arbre => arbre)) = 1);
   pragma Assert(individu_int.getNom(individu_int.getInformations(individu => arbre_genealogique.getElement(arbre => arbre))) = To_Unbounded_String("CONTANDIN"));

   --Verification que réécrire un nouvel arbre écrase l'ancien
   nom_individu := To_Unbounded_String("PAGNOL");
   prenom_individu := To_Unbounded_String("Marcel");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   creer(arbre => arbre, informations_individu => informations_individu);
   pragma Assert(arbre_genealogique.taille(arbre => arbre) = 1);
   pragma Assert(individu_int.getIdentifiant(arbre_genealogique.getElement(arbre => arbre)) = 1);
   pragma Assert(individu_int.getNom(individu_int.getInformations(individu => arbre_genealogique.getElement(arbre => arbre))) = To_Unbounded_String("PAGNOL"));


   --------  Test de procedure ajouterParent(arbre : in out T_Arbre_Bin ; enfant : in T_Individu ; informations_parent : in T_Informations ; parentEstPere : in Boolean); ---------------

   -- cas nominal père
   ind_1 := individu_int.creerIndividu(identifiant => 1);
   nom_individu := To_Unbounded_String("DE FUNES");
   prenom_individu := To_Unbounded_String("Louis");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => True);
   pragma Assert(arbre_genealogique.taille(arbre => arbre) = 2);
   pragma Assert(individu_int.getIdentifiant(arbre_genealogique.getElement(arbre_genealogique.getSousArbreDroit(arbre => arbre))) = 2);

   -- cas nominal mère
   ind_1 := individu_int.creerIndividu(identifiant => 1);
   nom_individu := To_Unbounded_String("DE FUNES");
   prenom_individu := To_Unbounded_String("Jeanne");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => False);

   pragma Assert(arbre_genealogique.taille(arbre => arbre) = 3);
   pragma Assert(individu_int.getIdentifiant(arbre_genealogique.getElement(arbre_genealogique.getSousArbreGauche(arbre => arbre))) = 3);

   -- exception element_absent
   ind_1 := individu_int.creerIndividu(identifiant => 4);
   begin
      ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => False);
      pragma Assert(False);
   exception
      when arbre_genealogique.element_absent =>
         pragma Assert(True);
   end;

   -- exception emplacement_invalide
   ind_1 := individu_int.creerIndividu(identifiant => 1);
   begin
      ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => True);
      pragma Assert(False);
   exception
      when arbre_genealogique.emplacement_invalide =>
         pragma Assert(True);
   end;

   ---------- Test de function obtenirNombreAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu) return Integer; -----------------
   ind_1 := individu_int.creerIndividu(identifiant => 3);
   nom_individu := To_Unbounded_String("DE BEAUVOIR");
   prenom_individu := To_Unbounded_String("Simone");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => False);

   ind_1 := individu_int.creerIndividu(identifiant => 1);
   pragma Assert(obtenirNombreAncetres(arbre => arbre, individu => ind_1) = 4);

   ind_1 := individu_int.creerIndividu(identifiant => 3);
   pragma Assert(obtenirNombreAncetres(arbre => arbre, individu => ind_1) = 2);

   ind_1 := individu_int.creerIndividu(identifiant => 6);
   pragma Assert(obtenirNombreAncetres(arbre => arbre, individu => ind_1) = 1);

   ind_1 := individu_int.creerIndividu(identifiant => 7);
   pragma Assert(obtenirNombreAncetres(arbre => arbre, individu => ind_1) = 0);

   -- Ajout de valeurs pour la suite du programme de test

   ind_1 := individu_int.creerIndividu(identifiant => 6);
   nom_individu := To_Unbounded_String("DE BEAUVOIR");
   prenom_individu := To_Unbounded_String("Jean");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => True);

   ind_1 := individu_int.creerIndividu(identifiant => 6);
   nom_individu := To_Unbounded_String("CURIE");
   prenom_individu := To_Unbounded_String("Marie");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => False);

   ind_1 := individu_int.creerIndividu(identifiant => 2);
   nom_individu := To_Unbounded_String("CARDIN");
   prenom_individu := To_Unbounded_String("Pierre");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => True);

   ind_1 := individu_int.creerIndividu(identifiant => 9);
   nom_individu := To_Unbounded_String("VEIL");
   prenom_individu := To_Unbounded_String("Simone");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => False);

   ind_1 := individu_int.creerIndividu(identifiant => 8);
   nom_individu := To_Unbounded_String("Moulin");
   prenom_individu := To_Unbounded_String("Jean");
   informations_individu := individu_int.creerInformations(nom => nom_individu, prenom => prenom_individu);
   ajouterParent(arbre => arbre, enfant => ind_1, informations_parent => informations_individu, parentEstPere => True);

   --     procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin);

   New_Line;New_Line;
   afficherArbreGenealogique(arbre => arbre);New_Line;New_Line;
   Put_Line("Resultat attendu : ");
   Put_Line(" 1 ( Nom : PAGNOL, Prenom : Marcel )");
   Put_Line(" -- Mere :  3 ( Nom : DE FUNES, Prenom : Jeanne ) ");
   Put_Line("     -- Mere :  6 ( Nom : DE BEAUVOIR, Prenom : Simone ) ");
   Put_Line("         -- Mere :  8 ( Nom : CURIE, Prenom : Marie ) ");
   Put_Line("             -- Pere :  11 ( Nom : Moulin, Prenom : Jean ) ");
   Put_Line("         -- Pere :  7 ( Nom : DE BEAUVOIR, Prenom : Jean ) ");
   Put_Line(" -- Pere :  2 ( Nom : DE FUNES, Prenom : Louis ) ");
   Put_Line("     -- Pere :  9 ( Nom : CARDIN, Prenom : Pierre ) ");
   Put_Line("         -- Mere :  10 ( Nom : VEIL, Prenom : Simone )");
   New_Line;

   begin
      afficherArbreGenealogique(arbre => arbre_genealogique.getSousArbreDroit(arbre_genealogique.getSousArbreDroit(arbre_genealogique.getSousArbreDroit(arbre => arbre))));
      pragma Assert(False);
   exception
      when arbre_genealogique.arbre_null =>
         pragma Assert(True);
   end;

   --     procedure afficherEnsembleUnSeulParent(arbre : in T_Arbre_Bin);
   New_Line;
   afficherEnsembleUnSeulParent(arbre => arbre);
   Put_Line("Resultat attendu : ");
   Put_Line(" 2 ( Nom : DE FUNES, Prenom : Louis ) ");
   Put_Line(" 9 ( Nom : CARDIN, Prenom : Pierre ) ");
   Put_Line(" 3 ( Nom : DE FUNES, Prenom : Jeanne ) ");
   Put_Line(" 8 ( Nom : CURIE, Prenom : Marie ) ");
   New_Line;New_Line;

   --     procedure afficherEnsembleDeuxParents(arbre : in T_Arbre_Bin);
   New_Line;
   afficherEnsembleDeuxParents(arbre => arbre);
   Put_Line("Resultat attendu : ");
   Put_Line(" 1 ( Nom : PAGNOL, Prenom : Marcel ) ");
   Put_Line(" 6 ( Nom : DE BEAUVOIR, Prenom : Simone )  ");
   New_Line;New_Line;

   --     procedure afficherEnsembleAucunParent(arbre : in T_Arbre_Bin);
   New_Line;
   afficherEnsembleAucunParent(arbre => arbre);
   Put_Line("Resultat attendu : ");
   Put_Line(" 10 ( Nom : VEIL, Prenom : Simone ) ");
   Put_Line(" 7 ( Nom : DE BEAUVOIR, Prenom : Jean ) ");
   Put_Line(" 11 ( Nom : Moulin, Prenom : Jean )  ");
   New_Line;New_Line;

   --     procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   --     procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   --     procedure afficherEnsembleDescendantsGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   --     procedure afficherEnsembleDescendants(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   --     procedure supprimerNoeudEtAncetres(arbre : in out T_Arbre_Bin ; individu : in T_Individu);
   Put_Line("Fin du test de arbre_genealog");
end test_arbre_genealog;
