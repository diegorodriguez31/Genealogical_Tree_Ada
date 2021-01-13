with Arbre_Bin;
with individu;

package Arbre_Genealog is

  pas_ancetre : exception;

-- Instanciation d'un individu avec l'identifiant de type Integer
package individu_Integer is new individu(T_Identifiant => Integer);
use individu_Integer;

-- Instanciation d'un individu avec l'identifiant de type String
package individu_String is new individu(T_Identifiant => String);
use individu_String;

-- Instanciation d'un Arbre_Bin avec les données génériques d'un arbre généalogique
package arbre_genealogique is new Arbre_Bin(T_Element => T_Individu);
use arbre_genealogique;

 -- Getters / Setters
 procedure set_id(arbre : in out T_Arbre_Genealog ; id : in Integer);
 function get_id(arbre : in T_Arbre_Genealog) return Integer;

 procedure set_generation(arbre : in out T_Arbre_Genealog ; generation : in Integer);
 function get_generation(arbre : in T_Arbre_Genealog) return Integer;

 procedure set_informations(arbre : in out T_Arbre_Genealog ; informations : in T_Individu);
 function get_informations(arbre : in T_Arbre_Genealog) return T_Individu;

 -- Semantique : Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   -- Paramètres :
   --     F_Individu : IN T_Individu -- Individu de l'arbre créé
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Un element null de type T_Arbre_Bin
   -- Exceptions : valeur_existante -- Renvoie valeur_existante si l'Id existe déjà
   function creer(F_Individu : in T_Individu) return T_Arbre_Bin;

   -- Semantique :  Ajouter un parent à un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Arbre auquel on ajoute un parent
   --    F_Parent : IN T_Arbre_Bin, -- Parent que l'on ajoute
   --    F_PereOuMere : IN Boolean -- Père si true et mère si false
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le parent ajouté
   -- Exceptions :
   --    arbre_null,  -- Renvoie arbre_null si l'arbre est null
   --    valeur_existante -- Renvoie valeur_existante si l'Id existe déjà
   procedure ajouterParent(F_Arbre : in out T_Arbre_Bin ; F_Parent : in T_Individu ; F_PereOuMere : in Boolean);

   -- Semantique :  Ajouter un père à un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Arbre auquel on ajoute le père
   --    F_Parent : IN T_Arbre_Bin, -- Parent que l'on ajoute
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le parent ajouté
   -- Exceptions :
   --    arbre_null,  -- Renvoie arbre_null si l'arbre est null
   --    valeur_existante -- Renvoie valeur_existante si l'Id existe déjà
   procedure ajouterPere(F_Arbre : in out T_Arbre_Bin ; F_Pere : in T_Individu);

   -- Semantique :  Ajouter une mère à un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Arbre auquel on ajoute la mère
   --    F_Parent : IN T_Arbre_Bin, -- Parent que l'on ajoute
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le parent ajouté
   -- Exceptions :
   --    arbre_null,  -- Renvoie arbre_null si l'arbre est null
   --    valeur_existante -- Renvoie valeur_existante si l'Id existe déjà
   procedure ajouterMere(F_Arbre : in out T_Arbre_Bin ; F_Mere : in T_Individu);

   -- Semantique : Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris)
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : Le nombre d'ancêtres est renvoyé
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   function nombreAncetres(F_Arbre : in T_Arbre_Bin) return Integer;

   -- Identifier les ancêtres d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : Les ancêtres de la génération donnée est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure identifierAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer, F_Compteur : in Integer);

   -- Semantique : Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des ancêtres est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure ensembleAncetres(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer, F_Compteur : in Integer);

   -- Sémantique : Identifier les descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   -- Pré-conditions : Néant
   -- Post-conditions : Les descendants de la génération donnée est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure identifierDescendants(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer);

   -- Sémantique : Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin, -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des descendants est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure ensembleDescendants(F_Arbre : in T_Arbre_Bin ; F_Generation : in Integer);

   -- Sémantique : Afficher l'arbre généalogique à partir d'un noeud donné
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Arbre à afficher à partir de ce noeud
   --    F_Compteur : IN Integer   -- Compteur pour l'affichage en tabulations
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure afficherArbreGen(F_Arbre : in T_Arbre_Bin);

   -- Sémantique : Supprimer, pour un arbre, un noeud et ses ancêtres
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud que l'on supprime
   -- Pré-conditions : Néant
   -- Post-conditions : Le noeud et ses ancêtres sont supprimés
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure supprimerNoeudEtAncetres(F_Arbre : in out T_Arbre_Bin);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont inconnus
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont pas de parent connu est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeAucunParent(F_Arbre : in T_Arbre_Bin);

   -- Sémantique : Obtenir l'ensemble des individus qui n'ont qu'un parent connu
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont qu'un parent connu est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeUnSeulParent(F_Arbre : in T_Arbre_Bin);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont connus
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus dont les deux parents sont connus est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeDeuxParents(F_Arbre : in T_Arbre_Bin);

 

   -- Sémantique : Obtenir l'ancêtre paternel d'une génération donnée
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : L'ancêtre est affiché s'il existe
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
  procedure ancetrePaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer, F_Compteur : in Integer);

   -- Sémantique : Obtenir l'ancêtre maternel d'une génération donnée
   -- Paramètres :
   --    F_Arbre : IN OUT T_Arbre_Bin -- Noeud à partir duquel on démarre la recherche
   --    F_Generation : IN Integer -- Génération par rapport au noeud donné
   --    F_Compteur : IN Integer -- Compteur pour trouver la génération relative
   -- Pré-conditions : Néant
   -- Post-conditions : L'ancêtre est affiché s'il existe
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
  procedure ancetreMaternel(F_Arbre : in T_Arbre_Bin; F_Generation : in Integer, F_Compteur : in Integer);

   -- Sémantique : Vérifie si deux arbres sont égaux
   -- Paramètres :
   --    F_Arbre1, F_Arbre2 : IN T_Arbre_Bin, -- Arbre entier
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
  function egaux(F_Arbre1, F_Arbre2 : in T_Arbre_Bin) return Boolean;

end Arbre_Genealog;
