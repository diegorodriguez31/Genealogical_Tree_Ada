package body Arbre_Bin is

   -- Initialiser un AB Abr. L’AB est vide.
   function Initialiser return T_Arb is
      Abr  : T_Arb;
   begin
      Abr := null;
      return Abr;
   end Initialiser;

   -- Est-ce qu’un AB Abr est vide ?
   function Est_Vide (Abr : T_Arb) return Boolean is
   begin
      return Abr = null;
   end Est_Vide;

   --Obtenir le nombre d’éléments d’un AB.
   function Taille (Abr : in T_Arb) return Integer is
   begin
      if not Est_Vide(Abr) then
         return taille(abr.all.sous_arbre_gauche) + taille(abr.all.sous_arbre_droit) + 1;
      else
         return 0;
      end if;
   end Taille;


   -- Insérer la donnée dans l’AB Abr.
   procedure inserer (Abr : in out T_Arb ; Donnee : in T_Element)is
   begin
      if Est_Vide(Abr) then
         Abr :=  new T_Noeud'(Donnee, null, null);
      else
         if InferieurDonnee(Donnee, Abr.all.Donnee) then
            Inserer(Abr.all.Sous_Arbre_Gauche, Donnee);
         else
            Inserer(Abr.all.Sous_Arbre_Droit, Donnee);
         end if;
      end if;
   end inserer;

   -- Recherche dans l’AB Abr.
   function est_present (Abr : T_Arb; donnee: in T_Element) return Boolean is
      trouve : Boolean := False;
   begin
      if Est_Vide(Abr) then
         null;
      else
         if Abr.all.donnee = donnee then
            trouve := True;
         else
            if SuperieurDonnee(Abr.all.donnee, donnee) then
               trouve := Recherche(Abr.all.sous_arbre_gauche, donnee);
            else
               trouve := Recherche(Abr.all.sous_arbre_droit, donnee);
            end if;
         end if;
      end if;
      return trouve;
   end est_present;

   -- Modifier la donnée dans l’AB Abr.
   procedure modifier (Abr : in out T_Arb ; src_donnee : in T_Element; tar_donnee : in T_Element) is
      noeud : T_Arb;
   begin
      if Est_Vide(Abr) then
         raise null_exception with "Modification d'un arbre vide impossible";
      else
         noeud := Abr;
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

   -- Supprimer la donnée dans l’AB Abr.
   procedure supprimer (Abr : in out T_Arb; donnee : in T_Element) is
      noeud_precedent : T_Arb;
      sous_arbre_droit : T_Arb;
      noeud : T_Arb;
   begin
      Put_Line("Entré dans supprimer");
      if Est_Vide(Abr) then
         raise null_exception with "Impossible de supprimer une valeur d'un arbre vide";
      else
         --recherche du noeud
         noeud := Abr;
         noeud_precedent := Abr;
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
               if Abr = noeud then
                  Abr := null;
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
                  if noeud = Abr then
                     Abr := Abr.Sous_Arbre_Gauche;
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
                     if noeud = Abr then
                        Abr := Abr.Sous_Arbre_Gauche;
                     else
                        if noeud = noeud_precedent.all.Sous_Arbre_Gauche then
                           noeud_precedent.Sous_Arbre_Gauche := noeud.all.Sous_Arbre_Gauche;
                        else
                           noeud_precedent.all.Sous_Arbre_Droit := noeud.all.Sous_Arbre_Gauche;
                        end if;
                     end if;
                  else
                     if noeud = Abr then
                        Abr := Abr.Sous_Arbre_Droit;
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

   -- Afficher un AB Abr
   procedure afficher (Abr : in T_Arb) is
   begin
      if Est_Vide(abr) then
         null;
      else
         Afficher(abr.all.Sous_Arbre_Gauche);
         AfficherDonnee(Abr.all.donnee);
         Afficher(abr.all.Sous_Arbre_Droit);
      end if;
   end afficher;

end Arbre_Bin;
