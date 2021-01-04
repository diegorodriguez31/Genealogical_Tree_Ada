package body Arbre_Bin is

   -- Initialiser un AB arbrere. L’AB est vide.
   function initialiser return T_Arb is
      arbre  : T_Arb;
   begin
      arbre := null;
      return arbre;
   end Initialiser;

   -- Est-ce qu’un AB arbrere est vide ?
   function Est_Vide (arbre : T_Arb) return Boolean is
   begin
      return arbre = null;
   end Est_Vide;

   --Obtenir le nombre d’éléments d’un AB.
   function Taille (arbre : in T_Arb) return Integer is
   begin
      if not Est_Vide(arbre) then
         return taille(abr.all.sous_arbre_gauche) + taille(abr.all.sous_arbre_droit) + 1;
      else
         return 0;
      end if;
   end Taille;


   -- Insérer la donnée dans l’AB arbre.
   procedure inserer (arbre : in out T_Arbre_Bin ; element_precedent : in T_Element; nouvel_element : in T_Element; inserer_a_droite : in Boolean) is
      element_prec : T_Element;
   begin
      if Est_Vide(arbre) then
         arbre :=  new T_Noeud'(nouvel_element, null, null);
      else
         if recherche(arbre => arbre, element => nouvel_element, retourner_precedent => false) != null then
            raise element_existant
         else
            element_prec := recherche(arbre => arbre, element => element_precedent, retourner_precedent => false);
            if element_prec = null then
               raise element_absent;
            else
               if inserer_a_droite then
                  if arbre.all.sous_arbre_droit != null then
                     raise emplacement_invalide;
                  else
                     Inserer(arbre.all.sous_arbre_droit, nouvel_element);
                  end if;
               else
                  if arbre.all.sous_arbre_gauche != null then
                     raise emplacement_invalide;
                  else
                     Inserer(arbre.all.sous_arbre_gauche, nouvel_element);
                  end if;
               end if;
            end if;
         end if;
      end if;
   end inserer;

   -- Recherche dans l’AB arbre.
   function recherche (arbre : T_Arbre_Bin; element : in T_Element; retourner_precedent : in Boolean) return T_Element is
      element : T_Element;
   begin
      element := null;
      if Est_Vide(arbre) then
         null;
      else
         if arbre.all.element.id = element.id then
            element := arbre.all.element;
         else
            if SuperieurDonnee(arbre.all.donnee, donnee) then
               trouve := Recherche(arbre.all.sous_arbre_gauche, donnee);
            else
               trouve := Recherche(arbre.all.sous_arbre_droit, donnee);
            end if;
         end if;
      end if;
      return trouve;
   end est_present;

   -- Modifier la donnée dans l’AB arbrere.
   procedure modifier (arbre : in out T_Arb ; src_donnee : in T_Element; tar_donnee : in T_Element) is
      noeud : T_Arb;
   begin
      if Est_Vide(arbre) then
         raise null_exception with "Modification d'un arbre vide impossible";
      else
         noeud := arbre;
         while (noeud.all.Donnee /= src_donnee) or (InferieurDonnee(src_donnee, noeud.all.Donnee) and noeud.all.Sous_Arbre_Gauche /= null)
           or (SuperieurDonnee(src_donnee, noeud.all.Donnee) and noeud.all.Sous_Arbre_Droit /= null) loop
            if InferieurDonnee(src_donnee, noeud.all.Donnee) then
               noeud := noeud.all.Sous_Arbre_Gauche;
            else
               noeud := noeud.all.Sous_Arbre_Droit;
            end if;
         end loop;
         if noeud.all.Donnee = src_donnee then
            noeud.Donnee := tar_donnee;
         else
            raise valeur_absente with "Modification d'une valeur absente de l'arbre";
         end if;
      end if;
   end modifier;

   -- Supprimer la donnée dans l’AB arbrere.
   procedure supprimer (arbre : in out T_Arb; donnee : in T_Element) is
      noeud_precedent : T_Arb;
      sous_arbre_droit : T_Arb;
      noeud : T_Arb;
   begin
      Put_Line("Entré dans supprimer");
      if Est_Vide(arbre) then
         raise null_exception with "Impossible de supprimer une valeur d'un arbre vide";
      else
         --recherche du noeud
         noeud := arbre;
         noeud_precedent := arbre;
         while (noeud.all.Donnee /= donnee) or (InferieurDonnee(donnee, noeud.all.Donnee) and noeud.all.Sous_Arbre_Gauche /= null)
           or (SuperieurDonnee(donnee, noeud.all.Donnee) and noeud.all.Sous_Arbre_Droit /= null) loop
            noeud_precedent := noeud;
            if InferieurDonnee(donnee, noeud.all.Donnee) then
               noeud := noeud.all.Sous_Arbre_Gauche;
            else
               noeud := noeud.all.Sous_Arbre_Droit;
            end if;
         end loop;
         if noeud.all.Donnee /= donnee then
            --Le noeud contenant la donnée recherchée n'est pas trouvé
            raise valeur_absente with "Modification d'une valeur absente de l'arbre";
         else
            Put_Line("Donnée trouvée dans supprimer");
            --Le noeud contenant la donnée recherchée est trouvé
            --cas d'une feuille
            if noeud.all.sous_arbre_gauche = null and noeud.all.sous_arbre_droit = null then
               Put_Line("Suppression de la feuille dans supprimer");
               if arbre = noeud then
                  arbre := null;
               else
                  if noeud = noeud_precedent.all.Sous_Arbre_Gauche then
                     noeud_precedent.Sous_Arbre_Gauche := null;
                  else
                     noeud_precedent.all.Sous_Arbre_Droit := null;
                  end if;
               end if;
            else
               --cas où il y a un sous-arbre gauche ET un droit
               if noeud.all.Sous_Arbre_Gauche /= null and noeud.all.Sous_Arbre_Droit /= null then
                  Put_Line("Suppression à gauche ET à droite");
                  --sauvgarde de la partie droite du sous arbre
                  sous_arbre_droit := noeud.all.Sous_Arbre_Droit;
                  --le noeud précédent pointe sur la partie gauche du sous arbre
                  if noeud = arbre then
                     arbre := arbre.Sous_Arbre_Gauche;
                  else
                     if noeud = noeud_precedent.all.Sous_Arbre_Gauche then
                        noeud_precedent.Sous_Arbre_Gauche := noeud.all.Sous_Arbre_Gauche;
                     else
                        noeud_precedent.all.Sous_Arbre_Droit := noeud.all.Sous_Arbre_Gauche;
                     end if;
                  end if;
                  noeud := noeud.all.Sous_Arbre_Gauche;
                  --Recherche de l'element le plus grand du sous arbre gauche ayant un sous arbre droit vide
                  while noeud.Sous_Arbre_Droit /= null loop
                     noeud := noeud.all.Sous_Arbre_Droit;
                  end loop;
                  noeud.all.Sous_Arbre_Droit := sous_arbre_droit;
               else
                  --cas où il n'y a qu'un sous arbre gauche XOR droit
                  Put_Line("Suppression à gauche OU à droite");
                  if noeud.all.Sous_Arbre_Gauche /= null then
                     if noeud = arbre then
                        arbre := arbre.Sous_Arbre_Gauche;
                     else
                        if noeud = noeud_precedent.all.Sous_Arbre_Gauche then
                           noeud_precedent.Sous_Arbre_Gauche := noeud.all.Sous_Arbre_Gauche;
                        else
                           noeud_precedent.all.Sous_Arbre_Droit := noeud.all.Sous_Arbre_Gauche;
                        end if;
                     end if;
                  else
                     if noeud = arbre then
                        arbre := arbre.Sous_Arbre_Droit;
                     else
                        if noeud = noeud_precedent.all.Sous_Arbre_Gauche then
                           noeud_precedent.Sous_Arbre_Gauche := noeud.all.Sous_Arbre_Droit;
                        else
                           noeud_precedent.all.Sous_Arbre_Droit := noeud.all.Sous_Arbre_Droit;
                        end if;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
   end supprimer;

   -- Afficher un AB arbrere
   procedure afficher (arbre : in T_Arb) is
   begin
      if Est_Vide(abr) then
         null;
      else
         Afficher(abr.all.Sous_Arbre_Gauche);
         AfficherDonnee(arbre.all.donnee);
         Afficher(abr.all.Sous_Arbre_Droit);
      end if;
   end afficher;

end Arbre_Bin;
