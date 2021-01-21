with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

with arbre_genealog; use arbre_genealog;

package menu is

   procedure lancerArbreGenealogique;

private

   -- Semantique : Traitement principal qui permet à l'utilisateur de manipuler l'arbre tant qu'il ne quitte pas le programme
   -- Paramètres :
   --     F_Arbre : IN T_Arbre_Bin, Arbre à manipuler
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure demanderSelection(arbre : in out arbre_genealogique.T_Arbre_Bin);

   -- Semantique : Traitement du choix de l'utilisateur par rapport au menu
   -- Paramètres :
   --     F_Choix : IN Integer, Choix de l'utilisateur
   --     F_Arbre : IN T_Arbre_Bin, Arbre appelé dans chaque commande
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure traitementSelection(selection : in Integer; arbre : in out arbre_genealogique.T_Arbre_Bin);


   -- Semantique : Affiche le menu des choix à l'utilisateur
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure afficherSelection;


   procedure selection_creer(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_ajouterParent(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_obtenirNombreAncetres(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherArbreGenealogique(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_supprimerNoeudEtAncetres(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleUnSeulParent(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleDeuxParents(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleAucunParent(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleAncetresGenerationUnique(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleAncetres(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleDescendantsGenerationUnique(arbre : in out arbre_genealogique.T_Arbre_Bin);
   procedure selection_afficherEnsembleDescendants(arbre : in out arbre_genealogique.T_Arbre_Bin);


   function getIndividuIdentifiant return individu_int.T_Individu;
   function getNombreGeneration return Integer;








   --  -- Semantique : Crée un arbre avec une donnée initiale
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre a initialiser
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_1_creer_arbre(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Ajoute un père à l'arbre passé en entrée
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre auquel on ajoute un père
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_2_ajouter_pere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Ajoute une mère à l'arbre passé en entrée
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre auquel on ajoute une mère
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_3_ajouter_mere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche le nombre d'ancêtres que possède l'arbre passé en entrée
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre duquel on cherche son nombre d'ancêtres
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_4_nombre_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche les ancêtres de génération demandé pour l'arbre passé en entrée
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre duquel on recherche des ancêtres de génération donnée
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_5_identifier_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche les descendants de génération demandé pour l'arbre passé en entrée
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre duquel on recherche des descendants de génération donnée
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_7_identifier_descendants(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche l'arbre généalogique
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre a afficher
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_9_afficher(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Supprime une branche de l'arbre
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre auquel on supprime une branche
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_10_supprimer_branche(F_Arbre : in out arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche le nombre d'individus qui n'ont aucun parent connu
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre duquel on fait la recherche
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_12_aucun_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche le nombre d'individus qui n'ont qu'un seul parent connu
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre duquel on fait la recherche
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_13_un_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
   --  -- Semantique : Affiche le nombre d'individus qui ont les deux parents connus
   --  -- Paramètres :
   --  --     F_Arbre : IN T_Arbre_Bin, Arbre duquel on fait la recherche
   --  -- Pré-conditions : Néant
   --  -- Post-conditions : Néant
   --  -- Exceptions : Néant
   --  procedure commande_14_deux_parents_connus(F_Arbre : in arbre_genealogique.T_Arbre_Bin);
   --
end menu;
