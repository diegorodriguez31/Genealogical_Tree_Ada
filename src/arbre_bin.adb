package body Arbre_Bin is

   -- Initialise l'arbre binaire
   procedure initialiser(arbre : out T_Arbre_Bin) is
   begin
      arbre := null;
   end initialiser;

-- Methode de thomas ?
  -- function creerArbre(Donnee : in T_Element) return T_ArbreBin is
    --  arbre  : T_ArbreBin;
   --begin
     -- arbre :=  new T_Noeud'(Donnee, null, null);
     -- return arbre;
   --end creerArbre;

   -- Determine si l'arbre est vide
   function estVide (arbre : in T_Arbre_Bin) return Boolean is
   begin
      return arbre = null;
   end estVide;

   -- Obtient le nombre d’éléments de l'arbre.
   function Taille (arbre : in T_Arbre_Bin) return Integer is
   begin
      if not estVide(arbre) then
         return taille(arbre.all.sous_arbre_gauche) + taille(arbre.all.sous_arbre_droit) + 1;
      else
         return 0;
      end if;
   end Taille;


   -- Insère l'element avec l'identifiant et la donnée dans l'arbre
   procedure inserer (arbre : in out T_Arbre_Bin ; element_precedent : in T_Element; nouvel_element : in T_Element; inserer_a_droite : in Boolean) is
      element_prec : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         arbre :=  new T_Noeud'(nouvel_element, null, null);
      else
         if recherche(arbre, element_precedent, False) = null then
            raise element_existant;
         else
            element_prec := recherche(arbre => arbre, element => element_precedent, retourner_precedent => false);
            if element_prec = null then
               raise element_absent;
            else
               if inserer_a_droite then
                  if arbre.all.sous_arbre_droit /= null then
                     raise emplacement_invalide;
                  else
                     Inserer(arbre.all.sous_arbre_droit, element_precedent, nouvel_element, True);
                  end if;
               else
                  if arbre.all.sous_arbre_gauche /= null then
                     raise emplacement_invalide;
                  else
                     Inserer(arbre.all.sous_arbre_gauche, element_precedent, nouvel_element, False);
                  end if;
               end if;
            end if;
         end if;
      end if;
   end inserer;

   -- Insère l'element à droite de l'arbre courant
    procedure insererSousArbreDroit(arbre : in out T_Arbre_Bin ; element_precedent : in T_Element : nouvel_element : in T_Element) is
    begin
      inserer(arbre, element_precedent, nouvel_element, true);
    end insererFilsDroit;

   -- Insère l'element à gauche de l'arbre courant
   procedure insererSousArbreGauche(arbre : in out T_Arbre_Bin ; element_precedent : in T_Element : nouvel_element : in T_Element) is
   begin
      inserer(arbre, element_precedent, nouvel_element, false);
   end insererFilsGauche;

   -- Semantique :  Renvoie l'élément de l'arbre courant
   function getDonnee(F_Arbre : T_Arbre_Bin) return T_Element is
   begin
      return F_Arbre.all.Element;
   end getDonnee;

   -- Recherche dans l'element dans l'arbre
   function recherche (arbre : T_Arbre_Bin; element : in T_Element; retourner_precedent : in Boolean) return T_Arbre_Bin is
      noeud : T_Arbre_Bin;
   begin
      noeud := arbre;
      while (not estVide(noeud)) and then (noeud.all.element /= element or noeud.all.Sous_Arbre_Gauche /= null or noeud.all.Sous_Arbre_Droit /= null) loop
         if retourner_precedent then
            if noeud.all.sous_arbre_gauche /= null and then egaux(noeud.all.sous_arbre_gauche.element, element) then
               return noeud;
            elsif noeud.all.sous_arbre_droit /= null and then egaux(noeud.all.sous_arbre_droit.element, element) then
               return noeud;
            else
               null;
            end if;
         else
            null;
         end if;
         noeud := recherche(arbre.all.sous_arbre_gauche, element, retourner_precedent);
         if noeud = null then
            noeud := recherche(arbre.all.sous_arbre_droit, element, retourner_precedent);
         else
            null;
         end if;
      end loop;
      return noeud;
   end recherche;

   -- Modifie l'element dans l'arbre
   procedure modifier (arbre : in out T_Arbre_Bin ; src_element : in T_Element; tar_element : in T_Element) is
      noeud : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null with "Modification d'un arbre vide impossible";
      else
         if not egaux(src_element, tar_element) then
            raise identifiant_incoherent with "Les elements à modifier ne correspondent pas";
         else
            noeud := recherche(arbre => arbre, element => src_element, retourner_precedent => false);
            if estVide(noeud) then
               raise element_absent with "Impossible de modifier un element absent";
            else
               noeud.element := tar_element;
            end if;
         end if;
      end if;
      end modifier;

      -- Supprime la donnée dans l’AB Abr.
      procedure supprimer (arbre : in out T_Arbre_Bin; element : in T_Element) is
         noeud : T_Arbre_Bin;
      begin
         if estVide(arbre) then
            raise arbre_null with "Impossible de supprimer une valeur d'un arbre vide";
         else
            noeud := recherche(arbre, element, False);
            if noeud = null then
               raise element_absent with "Suppression d'une valeur absente de l'arbre";
            else
               noeud := recherche(arbre, element, True);
               if noeud.all.sous_arbre_gauche /= null and then egaux(noeud.all.sous_arbre_gauche.all.element, element) then
                  noeud.all.sous_arbre_gauche := null;
               else
                  noeud.all.sous_arbre_droit := null;
               end if;
            end if;
         end if;
      end supprimer;

      -- Affiche l'arbre
      procedure afficher (arbre : in T_Arbre_Bin) is
      begin
         if estVide(arbre) then
            null;
         else
            afficherElement(arbre.all.element);
            Afficher(arbre.all.Sous_Arbre_Gauche);
            Afficher(arbre.all.Sous_Arbre_Droit);
         end if;
      end afficher;

      -- Renvoie le sous-arbre gauche
      function getSousArbreGauche(F_Arbre : in T_Arbre_Bin) return T_Arb_Bin is
      begin
         return F_arbre.all.Sous_Arbre_Gauche;
      end getSousArbreGauche;

      -- Renvoie le sous-arbre droit
      function getSousArbreDroit(F_Arbre : in T_Arbre_Bin) return T_Arb_Bin is
      begin
         return F_arbre.all.Sous_Arbre_Droit;
      end getSousArbreDroit;

   end Arbre_Bin;
