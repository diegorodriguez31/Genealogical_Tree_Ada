with Ada.Text_IO; use ada.Text_IO;

generic
   type T_Id is private;
   type T_Donnee is private;
   with function inferieur_donnee(Donnee_1 : in T_Element; Donnee_2 : in T_Element) return Boolean;
   with function superieur_donnee(Donnee_1 : in T_Element; Donnee_2 : in T_Element) return Boolean;
package Arbre_Bin is

   type T_Element is record
      id : T_Id;
      donnee : T_Donnee;
   end record;

   type T_Arbre_Bin is private;

   arbre_null : exception;
   element_absent : exception;
   element_existant : exception;
   emplacement_invalide : exception;

   -- Semantique : Initialiser l'arbre binaire
   -- Paramètres : Néant
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Un element null de type T_Arbre_Bin
   -- Exceptions : Néant
   function initialiser return T_Arbre_Bin;

   -- Semantique : Determiner si l'arbre est vide
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dont le catactère 'vide' doit être determinée
   -- Pré-conditionsns : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Un bouléen indiquant si l'arbre est vide
   -- Exceptions : Néant
   function estVide (arbre : in T_Arbre_Bin) return Boolean;

   -- Semantique :  Obtenir le nombre d’éléments de l'arbre.
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dont la taille doit être determinée
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : le nombre d'elements dans l'arbre donné
   -- Exceptions : Néant
   function taille (arbre : in T_Arbre_Bin) return Integer;

   -- Semantique :  Insérer l'element avec l'identifiant et la donnée dans l'arbre
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

   -- Semantique :  Recherche dans l'element dans l'arbre
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Un bouléen indiquant si la donnée est présente dans l'arbre
   -- Exceptions : Néant
   function est_present (arbre : T_Arbre_Bin; element : in T_Element) return Boolean;

   -- Semantique :  Modifier la donnée dans l’AB Abr.
   -- Pré-conditions : l'arbre n'est pas vide et la donnée src_donnee est présente dans l'arbre
   -- Post-conditions : La donnée src donnée à été remplacée par la donnée tar_donnée
   -- Exceptions : null_exception si l'arbe est vide, valeur_absente si la donnée src_donnee est absente
   procedure modifier (arbre : in out T_Arbre_Bin ; src_donnee : in T_Element; tar_donnee : in T_Element);

   -- Semantique :  Supprimer la donnée dans l’AB Abr.
   -- Pré-conditions : l'arbre n'est pas vide et la donnée donnee est présente dans l'arbre
   -- Post-conditions : Il y a une occurence de moins de la donnee à supprimer dans l'arbre
   -- Exceptions : null_exception si l'arbe est vide, valeur_absente si la donnée src_donnee est absente
   procedure supprimer (arbre : in out T_Arbre_Bin; donnee : in T_Element);

   -- Semantique :  Afficher un AB Abr
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est affiché selon le mode d'affichage GRD
   -- Exceptions : Néant
   generic
      with procedure afficher_donnee(Donnee : in T_Element);
   procedure afficher (arbre : in T_Arbre_Bin);

private
   type T_Noeud;
   type T_Arbre_Bin is access T_Noeud;

   type T_Noeud is record
      Element : T_Element;
      Sous_Arbre_Gauche : T_Arbre_Bin;
      Sous_Arbre_Droit : T_Arbre_Bin;
   end record;

end Arbre_Bin;
