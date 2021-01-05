
package Arbre_Genealog is

 -- Semantique : Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Un element null de type T_Arbre_Gen
   -- Exceptions : valeur_existante -- Renvoie valeur_existante si l'Id existe déjà
   function creer(Id : in T_Id ; Donnee : in T_Donnee) return T_Arbre_Gen;

   -- Semantique :  Ajouter un parent à un noeud donné
   -- Paramètres :
   --    Id : IN OUT T_Id, -- Identifiant du noeud auquel on ajoute un parent
   --    Parent : IN T_Arbre_Gen, -- Parent que l'on ajoute
   --    PereOuMere : IN Boolean -- Père si true et mère si false
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le parent ajouté
   -- Exceptions :
   --    arbre_null,  -- Renvoie arbre_null si l'arbre est null
   --    valeur_existante -- Renvoie valeur_existante si l'Id existe déjà
   procedure ajouterParent(Id : in T_Id ; Parent : in T_Arbre_Gen ; PereOuMere : in Boolean);

   -- Semantique : Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris)
   -- Paramètres :
   --    Id : IN OUT T_Id -- Identifiant du noeud de l'individu donné
   -- Pré-conditions : Néant
   -- Post-conditions : Le nombre d'ancêtres est renvoyé
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   function nombreAncetres(Id : in T_Id) return Integer;

   -- Identifier les ancêtres d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    Id : IN OUT T_Id -- Identifiant du noeud de l'individu donné
   --    Generation : IN Integer -- Génération par rapport au noeud donné
   -- Pré-conditions : Néant
   -- Post-conditions : Les ancêtres de la génération donnée est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure identifierAncetres(Id : in T_Id ; Generation : in Integer);

   -- Semantique : Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   -- Paramètres :
   --    Id : IN OUT T_Id, -- Identifiant du noeud de l'individu donné
   --    Generation : IN Integer -- Génération par rapport au noeud donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des ancêtres est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure ensembleAncetres(Id : in T_Id ; Generation : in Integer);

   -- Sémantique : Identifier les descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    Id : IN OUT T_Id -- Identifiant du noeud de l'individu donné
   --    Generation : IN Integer -- Génération par rapport au noeud donné
   -- Pré-conditions : Néant
   -- Post-conditions : Les descendants de la génération donnée est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure identifierDescendants(Id : in T_Id ; Generation : in Integer);

   -- Sémantique : Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    Id : IN OUT T_Id, -- Identifiant du noeud de l'individu donné
   --    Generation : IN Integer -- Génération par rapport au noeud donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des descendants est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure ensembleDescendants(Id : in T_Id ; Generation : in Integer);

   -- Sémantique : Afficher l'arbre à partir d'un noeud donné
   -- Paramètres :
   --    Id : IN OUT T_Id -- Identifiant du noeud de l'individu donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure afficherArbreGen(Id : in T_Id);

   -- Sémantique : Supprimer, pour un arbre, un noeud et ses ancêtres
   -- Paramètres :
   --    Id : IN OUT T_Id -- Identifiant du noeud de l'individu donné
   -- Pré-conditions : Néant
   -- Post-conditions : Le noeud et ses ancêtres sont supprimés
   -- Exceptions :
   --    arbre_null, -- Renvoie arbre_null si l'arbre est null
   --    valeur_absente -- Renvoie valeur_absente si le noeud correspondant à l'Id n'existe pas
   procedure supprimerNoeudEtAncetres(Id : in T_Id);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont inconnus
   -- Paramètres :
   --    arbre : IN T_Arbre_Gen -- Arbre donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont pas de parent connu est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeAucunParent(arbre : in T_Arbre_Gen);

   -- Sémantique : Obtenir l'ensemble des individus qui n'ont qu'un parent connu
   -- Paramètres :
   --    arbre : IN T_Arbre_Gen -- Arbre donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont qu'un parent connu est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeUnSeulParent(arbre : in T_Arbre_Gen);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont connus
   -- Paramètres :
   --    arbre : IN T_Arbre_Gen -- Arbre donné
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus dont les deux parents sont connus est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
   procedure listeDeuxParents(arbre : in T_Arbre_Gen);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont connus
   -- Paramètres :
   --    arbre : IN T_Arbre_Gen, -- Arbre entier
   --    compteur : IN Integer   -- Compteur pour l'affichage en tabulations
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre généalogique est affiché
   -- Exceptions : arbre_null -- Renvoie arbre_null si l'arbre est null
  procedure afficher(arbre : in T_ArbreGenealog;  compteur : Integer);

end Arbre_Genealog;
