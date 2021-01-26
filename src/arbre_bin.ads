with Ada.Text_IO; use ada.Text_IO;

generic
   --  type T_Id is private;
   --  type T_Donnee is private;
   type T_Element is private;
   with function estEquivalent(element_1 : in T_Element; element_2 : in T_Element) return Boolean;
package Arbre_Bin is

   --  type T_Element is record
   --     id : T_Id;
   --     donnee : T_Donnee;
   --  end record;

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
   procedure initialiser(arbre : out T_Arbre_Bin);

   -- Semantique : Determiner si l'arbre est vide
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dont le catactère 'vide' doit être determinée
   -- Pré-conditionsns : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : Un bouléen indiquant si l'arbre est vide
   -- Exceptions : Néant
   function estVide (arbre : in T_Arbre_Bin) return Boolean;

   -- Semantique :  Obtenir le nombre d'éléments de l'arbre.
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dont la taille doit être determinée
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : le nombre d'elements dans l'arbre donné
   -- Exceptions : Néant
   function taille (arbre : in T_Arbre_Bin) return Integer;

   -- Semantique :  Insérer l'element avec l'identifiant et la donnée dans l'arbre
   --    Si l'arbre ne contient pas de valeurs, les paramètres element_precedent et inserer_a_droite ne sont pas pris en compte
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut inserer
   --   element_precedent : IN T_Element, l'element après lequel il faut insérer
   --   nouvel_element : IN T_Element, l'element à insérer
   --   inserer_a_droite : IN Boolean, vrai si l'element doit être inséré à droite, faux si l'element doit être inséré à gauche
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre contient le nouvel élement si les informations entrées sont cohérentes avec l'arbre
   -- Exceptions :
   --   element_absent, s'il n'existe pas d'element de même identifiant que element precedent
   --   element_existant, s'il existe déjà un élément de même identifiant que nouvel_element
   --   emplacement_invalide, s'il existe déjà un element là où nouvel_element doit être inséré
   procedure inserer (arbre : in out T_Arbre_Bin ; element_precedent : in T_Element; nouvel_element : in T_Element; inserer_a_droite : in Boolean);

   -- Semantique :  Recherche dans l'element dans l'arbre
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut effectuer la recherche
   --   element : IN T_Element, l'element à rechercher
   --   retourner_precedent : in Boolean, vrai s'il faut retourner l'element précédent, faux s'il faut retourner l'element
   -- Pré-conditions : Néant
   -- Post-conditions : L'arbre est inchangé
   -- Retourne : l'element recherché ou l'element précedent selon le flag retourner_precedent. null si l'element n'as pas été trouvé.
   -- Exceptions :
   --  element_absent si l'element recherché n'est pas présent dans l'arbre
   function recherche (arbre : T_Arbre_Bin; element : in T_Element; retourner_precedent : in Boolean) return T_Arbre_Bin;

   -- Semantique :  Modifier l'element dans l'arbre
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut modifier un element
   --   src_element : IN T_Element, l'element à modifier
   --   tar_element : IN T_Element, la nouvelle valeur de l'élement
   -- Pré-conditions : Néant
   -- Post-conditions : l'element src donnée à été remplacée par la donnée tar_donnée
   -- Exceptions :
   --   null_exception si l'arbe est vide
   --   element_absent si la donnée src_donnee est absente
   procedure modifier (arbre : in out T_Arbre_Bin ; src_element : in T_Element; tar_element : in T_Element);

   -- Semantique :  Supprimer la donnée et le noeuds la suivant dans l'arbre
   -- Paramètres :
   --   arbre : IN T_Arbre_Bin, l'arbre binaire dans lequel il faut supprimer un element
   --   element : IN T_Element, l'element à supprimer
   -- Pré-conditions : Néant
   -- Post-conditions : l'élément à été supprimé de l'arbre
   -- Exceptions :
   --   arbre_null si l'arbe est vide
   --   element_absent si la donnée src_donnee est absente
   procedure supprimer (arbre : in out T_Arbre_Bin; element : in T_Element);

   --  Sematique : Retourne l'element du premier noeud de l'arbre donné en paramètre
   --  Paramètres  :
   --     arbre : l'arbre dont on veut l'element
   --  Pré-condition : Néant
   --  Post-conditionion : l'arbre est inchangé
   --  Retourne : T_Element, l'element du premier noeud de l'arbre donné en paramètre
   --  Exceptions:
   --     arbre_null : si l'arbre donné en paramètre est null
   function getElement(arbre : in T_Arbre_Bin) return T_Element;

   --  Sematique : Retourne le sous arbre droit de l'arbre donné en paramètre.
   --  Paramètres  :
   --     arbre : l'arbre dont on veut le sous arbre droit
   --  Pré-condition : Néant
   --  Post-conditionion : l'arbre est inchangé
   --  Retourne : T_Arbre_Bin, le sous arbre droit de l'arbre donné en paramètre.
   --  Exceptions:
   --     arbre_null : si l'arbre donné en paramètre est null
   function getSousArbreDroit(arbre : in T_Arbre_Bin) return T_Arbre_Bin;

   --  Sematique : Retourne le sous arbre gauche de l'arbre donné en paramètre.
   --  Paramètres  :
   --     arbre : l'arbre dont on veut le sous arbre gauche
   --  Pré-condition : Néant
   --  Post-conditionion : l'arbre est inchangé
   --  Retourne : T_Arbre_Bin, le sous arbre gauche de l'arbre donné en paramètre.
   --  Exceptions:
   --     arbre_null : si l'arbre donné en paramètre est null
   function getSousArbreGauche(arbre : in T_Arbre_Bin) return T_Arbre_Bin;


private
   type T_Noeud;
   type T_Arbre_Bin is access T_Noeud;

   type T_Noeud is record
      element : T_Element;
      sous_arbre_gauche : T_Arbre_Bin;
      sous_arbre_droit : T_Arbre_Bin;
   end record;

end Arbre_Bin;
