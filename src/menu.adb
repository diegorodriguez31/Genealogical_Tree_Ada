package body menu is


   procedure lancerArbreGenealogique is
      arbre : arbre_genealogique.T_Arbre_Bin;
      selection : Integer;
   begin
      Put_Line("Bievenue. Afin de commencer il vous faut entrer la personne de dernière generation dans l'arbre, les individus de génération antérieure pourront être ajoutés");
      creer(arbre => arbre);
      loop
         loop
            afficherSelection;
            begin
               Get(selection);
            exception
               when DATA_ERROR =>
                  Put_Line("Erreur de selection");
                  selection := -1;
                  Skip_Line;
            end;
            exit when selection >= 0 and selection < 14;
         end loop;
         exit when selection = 0;
         traitementSelection(selection, arbre);
      end loop;
   exception
      when others =>
         Put_Line("Une erreur est survenue. Fermeture du programme");
         Skip_Line;
   end lancerArbreGenealogique;

   procedure afficherSelection is
   begin
      New_Line;
      Put_Line("============================================================================================");
      Put_Line("=                                                                                          =");
      Put_Line("=  Selections possibles :                                                                  =");
      Put_Line("=                                                                                          =");
      Put_Line("=  1)  Recréer un arbre minimal coutenant le seul noeud racine, sans père ni mère          =");
      Put_Line("=  2)  Ajouter un parent (mère ou père) à un noeud donné                                   =");
      Put_Line("=  3)  Afficher le nombre d'ancêtres connus d'un individu donné (lui compris)              =");
      Put_Line("=  4)  Afficher l'arbre généalogique à partir d'un noeud donné                             =");
      Put_Line("=  5)  Supprimer, pour un arbre, un noeud et ses ancêtres                                  =");
      Put_Line("=  6)  Afficher l'ensemble des individus qui n'ont qu'un parent connu                      =");
      Put_Line("=  7)  Afficher l'ensemble des individus dont les deux parents sont connus                 =");
      Put_Line("=  8)  Afficher l'ensemble des individus dont les deux parents sont inconnus               =");
      Put_Line("=  9)  Afficher l'ensemble des ancêtres situés à une certaine génération d'un noeud donné  =");
      Put_Line("=  10) Afficher les ancêtres d'une génération donnée pour un noeud donné                   =");
      Put_Line("=  11) Identifier les descendants d'une génération donnée pour un noeud donné              =");
      Put_Line("=  12) Afficher la succession de descendants d'une génération donnée pour un noeud donné   =");
      Put_Line("=  13) Afficher entièrement l'arbre généalogique                                           =");
      Put_Line("=                                                                                          =");
      Put_Line("=  0)  Quitter le programme                                                                =");
      Put_Line("=                                                                                          =");
      Put_Line("============================================================================================");
      New_Line;
   end afficherSelection;

   procedure traitementSelection(selection : in Integer; arbre : in out arbre_genealogique.T_Arbre_Bin) is
   begin
      case selection is
         when 1 => selection_creer(arbre);
         when 2 => selection_ajouterParent(arbre);
         when 3 => selection_obtenirNombreAncetres(arbre);
         when 4 => selection_afficherArbreGenealogiqueNoeudDonne(arbre);
         when 5 => selection_supprimerNoeudEtAncetres(arbre);
         when 6 => selection_afficherEnsembleUnSeulParent(arbre);
         when 7 => selection_afficherEnsembleDeuxParents(arbre);
         when 8 => selection_afficherEnsembleAucunParent(arbre);
         when 9 => selection_afficherEnsembleAncetresGenerationUnique(arbre);
         when 10 => selection_afficherEnsembleAncetres(arbre);
         when 11 => selection_afficherEnsembleDescendantsGenerationUnique(arbre);
         when 12 => selection_afficherEnsembleDescendants(arbre);
         when 13 => selection_afficherArbreGenealogique(arbre);

         when others => Put_Line("Choix inconnu.");
      end case;
   exception
      when arbre_genealogique.arbre_null =>
         Put_Line("Une erreur est survenue, l'arbre va être réinitialisé.");
         Skip_Line;
         lancerArbreGenealogique;
      when arbre_genealogique.element_absent =>
         Put_Line("Aucun individu ne porte cet identifiant ou la generation demandée ne corresponds à aucun individu. Veuillez recommencer");
         Skip_Line;
   end traitementSelection;

   procedure selection_creer(arbre : out arbre_genealogique.T_Arbre_Bin) is
   begin
      creer(arbre => arbre);
   end selection_creer;

   procedure selection_ajouterParent(arbre : in out arbre_genealogique.T_Arbre_Bin) is
      informations_parent : individu_int.T_Informations;
      choix_parent : Integer;
      parent_est_pere  : Boolean;
   begin

      Put("Entrez les informations du parent ");
      informations_parent := individu_int.creerInformations;

      New_Line;
      Skip_Line;
      loop
         Put("Si le parent que vous ajoutez est le père, entrez 1, sinon entrez 2 : ");
         Get(choix_parent);
         exit when choix_parent = 1 or choix_parent = 2;
      end loop;
      parent_est_pere := (choix_parent = 1);
      ajouterParent(arbre => arbre, enfant => getIndividuIdentifiant, informations_parent => informations_parent, parentEstPere => parent_est_pere);
   exception
      when arbre_genealogique.emplacement_invalide =>
         Put_Line("L'individu concerné possède déjà un parent de même type que celui que vous voulez lui attribuer. Veuillez recommencer");
         Skip_Line;
   end selection_ajouterParent;

   procedure selection_obtenirNombreAncetres(arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      Put_Line("Nombre d'ancêtres de l'individu entré : " & Integer'Image(obtenirNombreAncetres(arbre => arbre, individu => getIndividuIdentifiant)));
   end selection_obtenirNombreAncetres;


   procedure selection_afficherArbreGenealogiqueNoeudDonne(arbre : in arbre_genealogique.T_Arbre_Bin) is
      abr : arbre_genealogique.T_Arbre_Bin;
   begin
      abr := arbre_genealogique.recherche(arbre => arbre, element => getIndividuIdentifiant, retourner_precedent => false);
      afficherArbreGenealogique(arbre => abr);
   end selection_afficherArbreGenealogiqueNoeudDonne;

   procedure selection_supprimerNoeudEtAncetres(arbre : in out arbre_genealogique.T_Arbre_Bin) is
   begin
      supprimerNoeudEtAncetres(arbre => arbre, individu => getIndividuIdentifiant);
   end selection_supprimerNoeudEtAncetres;

   procedure selection_afficherEnsembleUnSeulParent(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleUnSeulParent(arbre => arbre);
   end selection_afficherEnsembleUnSeulParent;

   procedure selection_afficherEnsembleDeuxParents(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleDeuxParents(arbre => arbre);
   end selection_afficherEnsembleDeuxParents;

   procedure selection_afficherEnsembleAucunParent(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleAucunParent(arbre => arbre);
   end selection_afficherEnsembleAucunParent;

   procedure selection_afficherEnsembleAncetresGenerationUnique(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleAncetresGenerationUnique(arbre => arbre, individu => getIndividuIdentifiant, generation => getNombreGeneration);
   end selection_afficherEnsembleAncetresGenerationUnique;

   procedure selection_afficherEnsembleAncetres(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleAncetres(arbre => arbre, individu => getIndividuIdentifiant, generation => getNombreGeneration);
   end selection_afficherEnsembleAncetres;

   procedure selection_afficherEnsembleDescendantsGenerationUnique(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleDescendantsGenerationUnique(arbre => arbre, individu => getIndividuIdentifiant, generation => getNombreGeneration);
   end selection_afficherEnsembleDescendantsGenerationUnique;

   procedure selection_afficherEnsembleDescendants(arbre : in  arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherEnsembleDescendants(arbre => arbre, individu => getIndividuIdentifiant, generation => getNombreGeneration);
   end selection_afficherEnsembleDescendants;

   procedure selection_afficherArbreGenealogique(arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      afficherArbreGenealogique(arbre => arbre);
   end selection_afficherArbreGenealogique;

   function getIndividuIdentifiant return individu_int.T_Individu is
      id_enfant : Integer;
      enfant : individu_int.T_Individu;
   begin
      Skip_Line;
      Put("Entrez l'identifiant de l'individu de référence : ");
      Get(id_enfant);
      enfant := individu_int.creerIndividu(identifiant => id_enfant);
      return enfant;
   end getIndividuIdentifiant;

   function getNombreGeneration return Integer is
      nombre_generation : Integer;
   begin
      Skip_Line;
      Put("Entrez le nombre de generations : ");
      Get(nombre_generation);
      return nombre_generation;
   end getNombreGeneration;

end menu;
