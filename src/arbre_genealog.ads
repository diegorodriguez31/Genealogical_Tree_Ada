with Ada.Text_IO; use Ada.Text_IO;
with Arbre_Bin;
with P_Individu;

package arbre_genealog is

   type T_Id is new Integer;

   procedure affichIdentifiant(identifiant : in Integer);
   function nullIdendifiant(identifiant : in Integer) return Boolean;
   -- Instanciation d'un individu avec l'identifiant de type Integer
   package individu_int is new P_Individu(T_Identifiant => Integer, estEquivalentIdentifiant => "=", afficherIdentifiant => affichIdentifiant, estNullIdentifiant => nullIdendifiant );
   use individu_int;

   -- Instanciation d'un Arbre_Bin avec les données génériques d'un arbre généalogique
   package arbre_genealogique is new Arbre_Bin(T_Element => T_Individu, estEquivalent => estEquivalentIndividu);
   use arbre_genealogique;

   -- Semantique : Crée un arbre minimal coutenant le seul noeud racine, sans père ni mère
   -- Paramètres :
   --     arbre : IN OUT T_Arbre_Bin, Arbre crée
   --     informations_individu : IN T_Individu, Individu ajouté dans l'arbre lors de sa création
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure creer(arbre : in out T_Arbre_Bin ; informations_individu : in T_Informations);

   -- Semantique : Ajoute un parent (mère ou père) à un noeud donné
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel un parent est ajouté
   --    enfant : IN OUT T_Arbre_Bin, noeud auquel il faut ajouter un parent
   --    parent : IN T_Informations, les informations du parent ajouté dans l'arbre
   --    parentEstPere : IN Boolean, Vrai si le parent à ajouter est le père de l'enfant, Faux sinon
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le parent ajouté
   -- Exceptions :
   --    arbre_null, si l'arbre est null (généré par l'arbre binaire)
   procedure ajouterParent(arbre : in out T_Arbre_Bin ; enfant : in T_Individu ; informations_parent : in T_Informations ; parentEstPere : in Boolean);

   -- Semantique : Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris).
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel les individus doivent être comptés
   --    individu : IN T_Individu, Individu duquel les ancêtres doivent être comptés
   -- Pré-conditions : Néant
   -- Post-conditions : Le nombre d'ancêtres est renvoyé
   -- Exceptions :
   --    arbre_null, si l'arbre est null (généré par l'arbre binaire)
   function obtenirNombreAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu) return Integer;

   -- Sémantique : Afficher l'arbre généalogique à partir d'un noeud donné.
   -- Paramètres :
   --    arbre : IN T_Arbre_Bin, Arbre à afficher
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché, ou un message indiquant que l'arbre est vide
   -- Exceptions :
   --    arbre_null, si l'arbre est null
   procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin);

   -- Sémantique : Supprimer, pour un arbre, un noeud et ses ancêtres.
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre duquel il faut supprimer un individu
   --    individu : IN T_Individu, Individu à supprimer de l'arbre avec ses ancêtres
   -- Pré-conditions : Néant
   -- Post-conditions : Le noeud et ses ancêtres sont supprimés de l'arbre
   -- Exceptions :
   --    arbre_null, si l'arbre est null (généré par l'arbre binaire)
   --    element_absent, s'il n'existe pas dans l'arbre une personne considérée équivalente à l'individu(généré par l'arbre binaire)
   procedure supprimerNoeudEtAncetres(arbre : in out T_Arbre_Bin ; individu : in T_Individu);

   -- Sémantique : Obtenir l'ensemble des individus qui n'ont qu'un parent connu.
   -- Paramètres :
   --    arbre : IN T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont qu'un parent connu est affiché
   -- Exceptions : Néant
   procedure afficherEnsembleUnSeulParent(arbre : in T_Arbre_Bin);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont connus.
   -- Paramètres :
   --    arbre : IN T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus dont les deux parents sont connus est affiché
   -- Exceptions : Néant
   procedure afficherEnsembleDeuxParents(arbre : in T_Arbre_Bin);

   -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont inconnus.
   -- Paramètres :
   --    F_Arbre : IN T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des individus qui n'ont pas de parent connu est affiché
   -- Exceptions : Néant
   procedure afficherEnsembleAucunParent(arbre : in T_Arbre_Bin);

   -- Semantique : Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel les individus doivent être recherchés
   --    individu : IN T_Individu, Individu duquel les ancêtres doivent être recherchés
   --    generation : IN Integer, Génération relative à l'individu donné à rechercher
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des ancêtres est affiché
   -- Exceptions :
   --    arbre_null, si l'arbre est null
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   -- Sémantique : Obtenir les ancêtres d'une génération donnée pour un noeud donné.
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   --    individu : IN T_Individu, Individu duquel les ancêtres doivent être recherchés
   --    generation : IN Integer,  Génération relative à l'individu donné à rechercher
   -- Pré-conditions : Néant
   -- Post-conditions : Les ancêtres de la génération donnée est affiché
   -- Exceptions :
   --    arbre_null, si l'arbre est null
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   -- Sémantique : Identifier les descendants d'une génération donnée pour un noeud donné.
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   --    individu : IN T_Individu, Individu duquel les descendants doivent être recherchés
   --    generation : IN Integer,  Génération relative à l'individu donné à rechercher
   -- Pré-conditions : Néant
   -- Post-conditions : Les descendants de la génération donnée est affiché
   -- Exceptions :
   --    arbre_null, si l'arbre est null
   procedure afficherEnsembleDescendantsGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

   -- Sémantique : Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   --    individu : IN T_Individu, Individu duquel les descendants doivent être recherchés
   --    generation : IN Integer
   -- Pré-conditions : Néant
   -- Post-conditions : L'ensemble des descendants est affiché
   -- Exceptions :
   --    arbre_null, si l'arbre est null
   procedure afficherEnsembleDescendants(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer);

private
   compteur_identifiant : Integer; -- Un compteur permettant d'affecter un identifiant unique à chaque nouvelle individu ajouté à l'arbre.


   -- Les surcharges suivantes permettent de prendre en compte la gestion de la génération lors des appels récursifs.
   -- Le paramètre additionnel ne devant être modifié par le client lors de l'utilisation


   -- Sémantique : Afficher l'arbre généalogique à partir d'un noeud donné.
   -- Paramètres :
   --    arbre : IN T_Arbre_Bin, Arbre à afficher
   --    compteurGenerationRelative : IN Integer, Compteur de la génération relativement à la racine de l'arbre
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché, ou un message indiquant que l'arbre est vide
   -- Exceptions : Néant
   procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin ; compteurGenerationRelative : in Integer);


   -- Semantique : Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel les individus doivent être recherchés
   --    individu : IN T_Individu, Individu duquel les ancêtres doivent être recherchés
   --    generation : IN Integer, Génération relative à l'individu donné à rechercher
   --    compteurGenerationRelative : IN Integer, Compteur de la génération relativement à l'individu
   -- Pré-conditions : arbre est non null
   -- Post-conditions : L'ensemble des ancêtres est affiché
   -- Exceptions : Néant
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; generation : in Integer ; compteurGenerationRelative : in Integer);


   -- Sémantique : Obtenir les ancêtres d'une génération donnée pour un noeud donné.
   -- Paramètres :
   --    arbre : IN OUT T_Arbre_Bin, Arbre dans lequel il faut effectuer la recherche
   --    individu : IN T_Individu, Individu duquel les ancêtres doivent être recherchés
   --    generation : IN Integer,  Génération relative à l'individu donné à rechercher
   --    compteurGenerationRelative : IN Integer, Compteur de la génération relativement à l'individu
   -- Pré-conditions : arbre est non null
   -- Post-conditions : Les ancêtres de la génération donnée est affiché
   -- Exceptions : Néant
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; generation : in Integer ; compteurGenerationRelative : in Integer);

end arbre_genealog;
