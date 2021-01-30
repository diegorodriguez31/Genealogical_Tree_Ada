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
      -- Si l'arbre est vide, l'initialiser avec le nouvel element.
      if estVide(arbre) then
         arbre :=  new T_Noeud'(nouvel_element, null, null);
      else
         --Sinon determiner si l'element à ajouter est équivalent à un element existant
         if recherche(arbre => arbre, element => nouvel_element, retourner_precedent => false) /= null then
            raise element_existant;
         else
            -- Sinon determiner si l'element de reference est présent dans l'arbre
            element_prec := recherche(arbre => arbre, element => element_precedent, retourner_precedent => false);
            if element_prec = null then
               raise element_absent;
            else
               --S'il faut insérer à droite, et que le sous arbre droit est vide
               if inserer_a_droite then
                  if not estVide(element_prec.all.sous_arbre_droit) then
                     raise emplacement_invalide;
                  else
                     --Inserer le nouvel element dans le sous arbre droit de l'element de reference
                     Inserer(element_prec.all.sous_arbre_droit, element_precedent, nouvel_element, True);
                  end if;
               else
               --S'il faut insérer à droite, et que le sous arbre gauche est vide
                  if not estVide(element_prec.all.sous_arbre_gauche)then
                     raise emplacement_invalide;
                  else
                     --Inserer le nouvel element dans le sous arbre gauche de l'element de reference
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
      --Si la racine correponds à l'element recherché, le retourner
      if not estVide(noeud) and then estEquivalent(noeud.all.element, element) then
         if retourner_precedent then
            raise element_absent with "Le noeud demande est a la base de l'arbre binaire. Il n'as donc pas de precedent";
         else
            return noeud;
         end if;
      end if;
      -- Tant que l'element actuel ne corresponds pas à l'element recherché et que l'element actuel n'est pas vide
      while (not estVide(noeud)) and then not estEquivalent(noeud.all.element,element ) loop
         --S'il faut retourner le noeud précédent, rechercher dans les sous arbres droits et gauche
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
         --Rechercher récursivement dans le sous arbre gauche
         noeud := recherche(arbre.all.sous_arbre_gauche, element, retourner_precedent);
         -- Si la valeur n'est pas trouvée dans le sous arbre gauche rechercher recursivement dans le sous arbre droit
         if noeud = null then
            noeud := recherche(arbre.all.sous_arbre_droit, element, retourner_precedent);
         else
            null;
         end if;
      end loop;

      return noeud;
   end recherche;

   -- Modifier l'element dans l'arbre
   -- Non utilisé
   procedure modifier (arbre : in out T_Arbre_Bin ; src_element : in T_Element; tar_element : in T_Element) is
      noeud : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null with "Modification d'un arbre vide impossible";
      else
         if  recherche(arbre => arbre, element => tar_element, retourner_precedent => False) /= null then
            raise element_existant with ("L'element cible à une valeur deja existante dans l'arbre");
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
      --Si l'arbre est vide, lever une exception
      if estVide(arbre) then
         raise arbre_null with "Impossible de supprimer une valeur d'un arbre vide";
      else
         --determiner si l'element à supprimer est présent dans l'arbre
         noeud := recherche(arbre, element, False);
         if noeud = null then
            raise element_absent with "Suppression d'une valeur absente de l'arbre";
         elsif estEquivalent(arbre.element, element) then
            --Si l'element est la racinde de l'arbre, le supprimer
            arbre := null;
         else
            --Sinon rechercher l'element precedent de l'element à supprimer
            noeud := recherche(arbre, element, True);
            --Supprimer le sous arbre dont la racine est l'element à supprimer
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
