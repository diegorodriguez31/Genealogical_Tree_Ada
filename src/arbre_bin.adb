package body Arbre_Bin is

   -- Initialiser l'arbre binaire
   procedure initialiser(arbre : out T_Arbre_Bin) is
   begin
      arbre := null;
   end initialiser;

   -- Determiner si l'arbre est vide
   function estVide (arbre : T_Arbre_Bin) return Boolean is
   begin
      return arbre = null;
   end estVide;

   -- Obtenir le nombre d'éléments de l'arbre.
   function Taille (arbre : in T_Arbre_Bin) return Integer is
   begin
      if not estVide(arbre) then
         return taille(arbre.all.sous_arbre_gauche) + taille(arbre.all.sous_arbre_droit) + 1;
      else
         return 0;
      end if;
   end Taille;


   -- Insérer l'element avec l'identifiant et la donnée dans l'arbre
   procedure inserer (arbre : in out T_Arbre_Bin ; element_precedent : in T_Element; nouvel_element : in T_Element; inserer_a_droite : in Boolean) is
      element_prec : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         arbre :=  new T_Noeud'(nouvel_element, null, null);
      else
         if recherche(arbre => arbre, element => nouvel_element, retourner_precedent => false) /= null then raise
              element_existant;
         else
            element_prec := recherche(arbre => arbre, element => element_precedent, retourner_precedent => false);
            if element_prec = null then
               raise element_absent;
            else
               if inserer_a_droite then
                  if not estVide(element_prec.all.sous_arbre_droit) then
                     raise emplacement_invalide;
                  else
                     Inserer(element_prec.all.sous_arbre_droit, element_precedent, nouvel_element, True);
                  end if;
               else
                  if not estVide(element_prec.all.sous_arbre_gauche)then
                     raise emplacement_invalide;
                  else
                     Inserer(element_prec.all.sous_arbre_gauche, element_precedent, nouvel_element, False);
                  end if;
               end if;
            end if;
         end if;
      end if;
   end inserer;

   -- Recherche dans l'element dans l'arbre
   function recherche (arbre : T_Arbre_Bin; element : in T_Element; retourner_precedent : in Boolean) return T_Arbre_Bin is
      noeud : T_Arbre_Bin;
   begin
      noeud := arbre;
      if not estVide(noeud) and then estEquivalent(noeud.all.element, element) then
         if retourner_precedent then
            raise element_absent with "Le noeud demandé est à la base de l'arbre binaire. Il n'as donc pas de précédent";
         else
            return noeud;
         end if;
      end if;
      while (not estVide(noeud)) and then not estEquivalent(noeud.all.elemen,element ) loop
         if retourner_precedent then
            if noeud.all.sous_arbre_gauche /= null and then estEquivalent(noeud.all.sous_arbre_gauche.element, element) then
               return noeud;
            elsif noeud.all.sous_arbre_droit /= null and then estEquivalent(noeud.all.sous_arbre_droit.element, element) then
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

   -- Modifier l'element dans l'arbre
   procedure modifier (arbre : in out T_Arbre_Bin ; src_element : in T_Element; tar_element : in T_Element) is
      noeud : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null with "Modification d'un arbre vide impossible";
      else
         if  recherche(arbre => arbre, element => tar_element, retourner_precedent => False) /= null then
            raise identifiant_incoherent with ("L'élément cible à une valeur deja existante dans l'arbre");
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

   -- Supprimer la donnée dans l'AB Abr.
   procedure supprimer (arbre : in out T_Arbre_Bin; element : in T_Element) is
      noeud : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null with "Impossible de supprimer une valeur d'un arbre vide";
      else
         noeud := recherche(arbre, element, False);
         if noeud = null then
            raise element_absent with "Suppression d'une valeur absente de l'arbre";
         elsif estEquivalent(arbre.element, element) then
            arbre := null;
         else
            noeud := recherche(arbre, element, True);
            if noeud.all.sous_arbre_gauche /= null and then estEquivalent(noeud.all.sous_arbre_gauche.all.element, element) then
               noeud.all.sous_arbre_gauche := null;
            else
               noeud.all.sous_arbre_droit := null;
            end if;
         end if;
      end if;
   end supprimer;


   --  Retourne l'element du premier noeud de l'arbre donné en paramètre
   function getElement(arbre : in T_Arbre_Bin) return T_Element is
   begin
      if arbre = null then
         raise arbre_null with "Impossible de renvoyer l'element d'un arbre vide";
      else
         return arbre.all.element;
      end if;
   end getElement;

   --  Retourne le sous arbre droit de l'arbre donné en paramètre.
   function getSousArbreDroit(arbre : in T_Arbre_Bin) return T_Arbre_Bin is
   begin
      if arbre = null then
         raise arbre_null with "Impossible de renvoyer le sous arbre droit d'un arbre null";
      else
         return arbre.all.sous_arbre_droit;
      end if;
   end getSousArbreDroit;

   --  Retourne le sous arbre gauche de l'arbre donné en paramètre.
   function getSousArbreGauche(arbre : in T_Arbre_Bin) return T_Arbre_Bin is
   begin
      if arbre = null then
         raise arbre_null with "Impossible de renvoyer le sous arbre gauche d'un arbre null";
      else
         return arbre.all.sous_arbre_gauche;
      end if;
   end getSousArbreGauche;

end Arbre_Bin;
