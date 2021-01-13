with Ada.Text_IO; use ada.Text_IO;

generic
   type T_Element is private;
   with function egaux(element1 : in T_Element; element2 : in T_Element) return Boolean;
package Arbre_Bin is

   type T_Arbre_Bin is private;

   arbre_null : exception;
   element_absent : exception;
   element_existant : exception;
   emplacement_invalide : exception;
   identifiant_incoherent : exception;
   est_feuille : exception;

   -- Semantique : Initialise l'arbre binaire
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Exceptions : Néant
   procedure initialiser initialiser(arbre : out T_Arbre_Bin);


   -- Semantique : Determine si l'arbre est vide
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dont le catactère 'vide' doit être determinée
   -- Pré-conditionsns : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Boolean Un bouléen indiquant si l'arbre est vide
   -- Exceptions : Néant
   function estVide (arbre : in T_Arbre_Bin) return Boolean;

   -- Semantique :  Obtient le nombre d’éléments de l'arbre.
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dont la taille doit être determinée
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Integer le nombre d'elements dans l'arbre donné
   -- Exceptions : Néant
   function taille (arbre : in T_Arbre_Bin) return Integer;

   -- Semantique :  Insère l'element avec l'identifiant et la donnée dans l'arbre
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut inserer
   --   element_precedent : IN T_Element, l'element après lequel il faut insérer
   --   nouvel_element : in T_Element, l'element à insérer
   --   inserer_a_droite : in Boolean, vrai si l'element doit être inséré à droite, faux si l'element doit être inséré à gauche
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le nouvel élement si les informations entrées sont cohérentes avec l'arbre
   -- Exceptions :
   --   element_absent, s'il n'existe pas d'element de même identifiant que element precedent
   --   element_existant, s'il existe déjà un élément de même identifiant que nouvel_element
   --   emplacement invalide, s'il existe déjà un element là où nouvel_element doit être inséré
   procedure inserer (arbre : in out T_Arbre_Bin ; element_precedent : in T_Element; nouvel_element : in T_Element; inserer_a_droite : in Boolean);

   -- Semantique :  Insère l'element à droite de l'arbre courant
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut inserer
   --   element_precedent : IN T_Element, l'element après lequel il faut insérer
   --   nouvel_element : in T_Element, l'element à insérer
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le nouvel élement à droite de l'arbre courant si les informations entrées sont cohérentes avec l'arbre
   -- Exceptions :
   --   element_absent, s'il n'existe pas d'element de même identifiant que element precedent
   --   element_existant, s'il existe déjà un élément de même identifiant que nouvel_element
   --   emplacement invalide, s'il existe déjà un element là où nouvel_element doit être inséré
   procedure insererSousArbreDroit(arbre : in out T_Arbre_Bin ; element_precedent : in T_Element : nouvel_element : in T_Element);

   -- Semantique :  Insère l'element à gauche de l'arbre courant
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut inserer
   --   element_precedent : IN T_Element, l'element après lequel il faut insérer
   --   nouvel_element : in T_Element, l'element à insérer
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le nouvel élement à gauche de l'arbre courant si les informations entrées sont cohérentes avec l'arbre
   -- Exceptions :
   --   element_absent, s'il n'existe pas d'element de même identifiant que element precedent
   --   element_existant, s'il existe déjà un élément de même identifiant que nouvel_element
   --   emplacement invalide, s'il existe déjà un element là où nouvel_element doit être inséré
   procedure insererSousArbreGauche(arbre : in out T_Arbre_Bin ; element_precedent : in T_Element : nouvel_element : in T_Element);

   -- Semantique :  Renvoie l'élément de l'arbre courant
   -- Paramètres :
   --   F_Arbre : IN T_Arbre_Bin, l'arbre binaire courant
   -- Pré-conditions : Néant
   -- Post-conditions : La donnée de l'arbre est renvoyée
   -- Retourne : T_Element la donnée de l'arbre courant ou null si l'element n'as pas été trouvé.
   -- Exceptions : Néant.
   function getDonnee(F_Arbre : T_Arbre_Bin) return T_Element;

   -- Semantique :  Recherche dans l'element dans l'arbre
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut effectuer la recherche
   --   element : IN T_Element, l'element à rechercher
   --   retourner_precedent : in Boolean, vrai s'il faut retourner l'element précédent, faux s'il faut retourner l'element
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : T_Arbre_Bin l'arbre binaire recherché ou l'element précedent selon le flag retourner_precedent. null si l'element n'as pas été trouvé.
   -- Exceptions : Néant.
   function recherche (arbre : T_Arbre_Bin; element : in T_Element; retourner_precedent : in Boolean) return T_Arbre_Bin;

   -- Semantique :  Modifie l'element dans l'arbre
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut modifier un element
   --   src_element : IN T_Element, l'element à modifier
   --   tar_element : IN T_Element, la nouvelle valeur de l'élement
   -- Pré-conditions : Néant
   -- Post-conditions : l'element src donnée à été remplacée par la donnée tar_donnée
   -- Exceptions :
   --   null_exception si l'arbe est vide
   --   valeur_absente si la donnée src_donnee est absente
   --   identifiant_incoherent si l'identifiant de src_element ne corresponds pas à celui de tar_element
   procedure modifier (arbre : in out T_Arbre_Bin ; src_element : in T_Element; tar_element : in T_Element);

   -- Semantique :  Supprime la donnée dans l’AB Abr.
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut supprimer un element
   --   element : IN T_Element, l'element à supprimer
   -- Pré-conditions : Néant
   -- Post-conditions : l'élément à été supprimé de l'arbre
   -- Exceptions :
   --   null_exception si l'arbe est vide
   --   valeur_absente si la donnée src_donnee est absente
   procedure supprimer (arbre : in out T_Arbre_Bin; element : in T_Element);

   -- Semantique :  Affiche l'arbre dans l'ordre préfixé
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire à afficher
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché
   -- Exceptions : Néant
   generic
      with procedure afficherElement(Element : in T_Element);
   procedure afficher (arbre : in T_Arbre_Bin);

   -- Semantique :  Renvoie le sous-arbre gauche de l'arbre donné en entrée
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut effectuer la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : Le sous-arbre gauche est renvoyé
   -- Retourne : T_Arbre_Bin Le sous-arbre gauche de l'arbre courant
   -- Exceptions :
   --    est_feuille si l'arbre donné est une feuille
   function getSousArbreGauche(arbre : in T_Arbre_Bin) return T_Arbre_Bin;

   -- Semantique :  Renvoie le sous-arbre droit de l'arbre donné en entrée
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut effectuer la recherche
   -- Pré-conditions : Néant
   -- Post-conditions : Le sous-arbre droit est renvoyé
   -- Retourne : T_Arbre_Bin Le sous-arbre droit de l'arbre courant
   -- Exceptions :
   --    est_feuille si l'arbre donné est une feuille
   function getSousArbreDroit(arbre : in T_Arbre_Bin) return T_Arbre_Bin;

private
   type T_Noeud;
   type T_Arbre_Bin is access T_Noeud;

   type T_Noeud is record
      Element : T_Element;
      Sous_Arbre_Gauche : T_Arbre_Bin;
      Sous_Arbre_Droit : T_Arbre_Bin;
   end record;

end arbre_Bin;