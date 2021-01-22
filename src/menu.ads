with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

with arbre_genealog; use arbre_genealog;

package menu is

   -- Semantique : Permet d'agir sur l'arbre généalogique
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure lancerArbreGenealogique;

private

   -- Semantique : Permet de d'exectuer le sous programme correspondant à la selection de l'utilisateur
   -- Paramètres :
   --     selection : in Integer, la selection de l'utilisateur
   --     arbre : IN arbree_genealogique.T_Arbre_Bin, l'arbre commun au programme et aux sous programmes
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure traitementSelection(selection : in Integer; arbre : in out arbre_genealogique.T_Arbre_Bin);


   -- Semantique : Afficher le menu de selection à l'ecran
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure afficherSelection;

   -- Semantique : Créer un nouvel arbre genealogique
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à créer
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_creer(arbre : out arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Ajouter un parent à un individu
   -- Paramètres :
   --     arbre : IN OUT arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_ajouterParent(arbre : in out arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher le nombre d'ancêtres connus d'un individu donné (lui compris)
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_obtenirNombreAncetres(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher l'arbre généalogique à partir d'un noeud donné
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherArbreGenealogiqueNoeudDonne(arbre : in  arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Supprimer, pour un arbre, un noeud et ses ancêtres
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_supprimerNoeudEtAncetres(arbre : in out arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher l'ensemble des individus qui n'ont qu'un parent connu
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleUnSeulParent(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher l'ensemble des individus dont les deux parents sont connus
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleDeuxParents(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher l'ensemble des individus dont les deux parents sont inconnus
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleAucunParent(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleAncetresGenerationUnique(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher les ancêtres d'une génération donnée pour un noeud donné
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleAncetres(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Identifier les descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleDescendantsGenerationUnique(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher la succession de descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherEnsembleDescendants(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Afficher entièrement l'arbre généalogique
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure selection_afficherArbreGenealogique(arbre : in arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Demande un identifiant à l'utilisateur puis genere un individu portant cet identifiant
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   --      Retourne : individu_int.T_Individu, un individu portant l'identifiant entré en paramètre
   -- Exceptions : Néant
   function getIndividuIdentifiant return individu_int.T_Individu;

   -- Semantique : Demande à l'utilisateur le nombre de generations pour lesquels le traitement doit être effectué
   -- Paramètres :
   --     arbre : IN arbre_genealogique.T_Arbre_Bin, l'arbre à traiter
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   function getNombreGeneration return Integer;

end menu;
