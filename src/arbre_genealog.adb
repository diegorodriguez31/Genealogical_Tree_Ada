package body arbre_genealog is

   -- Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   function creer(F_Individu : in T_Individu) return T_Arbre_Gen is
      arbre : T_Arbre_Bin;
   begin
      arbre := arbre_genealogique.creer(F_Individu);
      return arbre;
   end creer;

   -- Ajouter un parent à un noeud donné
   procedure ajouterParent(F_Arbre : in out T_Arbre_Bin ; F_Parent : in T_Individu ; F_PereOuMere : in Boolean) is
      begin
      if(F_PereOuMere) then
         arbre_genealogique.insererSousArbreGauche;
      else
         arbre_genealogique.insererSousArbreDroit;
      end if;
   end ajouterParent;

   -- Ajoute un père à un noeud donné
   procedure ajouterPere(F_Arbre : in out T_Arbre_Bin ; F_Pere : in T_Individu) is
   begin
      ajouterParent(F_Arbre, F_Pere, true);
   end ajouterPere;

   -- Ajoute un mère à un noeud donné
   procedure ajouterMere(F_Arbre : in out T_Arbre_Bin ; F_Mere : in T_Individu) is
   begin
      ajouterParent(F_Arbre, F_Mere, false);
   end ajouterMere;


   -- Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris)
   function nombreAncetres(F_Arbre : in T_Arb_Bin) return Integer is
   begin
         return arbre_genealogique.taille(F_Arbre);
   end nombreAncetres;

   --Identifier les ancêtres d'une génération donnée pour un noeud donné
   procedure identifierAncetres(F_Arbre : in T_Arb_Bin ; F_Generation : in Integer, F_Compteur : in Integer) is
   begin
      if F_Compteur = F_Generation then
         Put(F_Arbre.all.Element.all.Id);
         Put(", ");
      while F_Compteur /= F_Generation loop
         identifierAncetres(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
         identifierAncetres(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
      end loop;

   end identifierAncetres;

   -- Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   procedure ensembleAncetres(F_Arbre : in T_Arb_Bin ; F_Generation : in Integer, F_Compteur : in Integer) is
   begin
      Put(F_Arbre.all.Element.all.Id);
      Put(", ");
      while F_Compteur /= F_Generation loop
         ensembleAncetres(getSousArbreGauche(F_Arbre), F_Generation, F_Compteur + 1);
         ensembleAncetres(getSousArbreDroit(F_Arbre), F_Generation, F_Compteur + 1);
      end loop;
   end ensembleAncetres;

   -- Identifier les descendants d'une génération donnée pour un noeud donné
   procedure identifierDescendants(F_Arbre : in T_Arb_Bin ; F_Generation : in Integer) is
   begin
      Put(F_Arbre.all.Element.all.Id);
   -- soit j'ajoute un pointeur
   -- soit je fais un calcul à partir des descendants
   end identifierDescendants;

   -- Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   procedure ensembleDescendants(F_Arbre : in T_Arb_Bin ; F_Generation : in Integer) is
   begin
   end ensembleDescendants;

   -- Afficher l'arbre à partir d'un noeud donné
   procedure afficherArbreGen(F_Arbre : in T_Arb_Bin) is
   begin
   end afficherArbreGen;

   -- Supprimer, pour un arbre, un noeud et ses ancêtres
   procedure supprimerNoeudEtAncetres(F_Arbre : in out T_Arb_Bin) is
   begin
   end supprimerNoeudEtAncetres;

   -- Obtenir l'ensemble des individus dont les deux parents sont inconnus
   procedure listeAucunParent(F_Arbre_Entier : in T_Arbre_Bin) is
   begin
      if(F_Arbre_Entier.all.sous_arbre_droit = null and F_Arbre_Entier.all.sous_arbre_gauche = null) then
         Put(F_Arbre_Entier.all.Element.all.id);
         Put(", ");
      end if;
      listeAucunParent(getSousArbreGauche(F_Arbre_Entier));
      listeAucunParent(getSousArbreDroit(F_Arbre_Entier));
   end listeAucunParent;

   -- Obtenir l'ensemble des individus qui n'ont qu'un parent connu
   procedure listeUnSeulParent(F_Arbre_Entier : in T_Arbre_Bin) is
   begin
      if(F_Arbre_Entier.all.sous_arbre_droit = null xor F_Arbre_Entier.all.sous_arbre_gauche = null) then
         Put(F_Arbre_Entier.all.Element.all.id);
         Put(", ");
      end if;
      listeUnSeulParent(getSousArbreGauche(F_Arbre_Entier));
      listeUnSeulParent(getSousArbreDroit(F_Arbre_Entier));
   end listeUnSeulParent;

   -- Obtenir l'ensemble des individus dont les deux parents sont connus
   procedure listeDeuxParents(F_Arbre_Entier : in T_Arbre_Bin) is
   begin
      if(F_Arbre_Entier.all.sous_arbre_droit /= null and F_Arbre_Entier.all.sous_arbre_gauche /= null) then
         Put(F_Arbre_Entier.all.Element.all.id);
         Put(", ");
      end if;
      listeDeuxParents(getSousArbreGauche(F_Arbre_Entier));
      listeDeuxParents(getSousArbreDroit(F_Arbre_Entier));
   end listeDeuxParents;

   -- Affiche l'arbre généalogique
   procedure afficher(F_Arbre_Entier : in T_Arbre_Bin;  F_Compteur : Integer) is
   begin
      if estVide(arbre) then
         null;
      else
         --afficherDonneeId(arbre.all.donnee.id);

         if estVide(arbre.all.Sous_Arbre_Gauche) then
            null;
         else
            New_Line;
            for j in 0..F_Compteur loop
               Put("    ");
            end loop;
            Put("-- pere : ");
            afficher(arbre.all.Sous_Arbre_Gauche, F_Compteur+1);
         end if;
         if estVide(arbre.all.Sous_Arbre_Droit) then
            null;
         else
            New_Line;
            for j in 0..F_Compteur loop
               Put("    ");
            end loop;
            Put("-- mere : ");
            afficher(arbre.all.Sous_Arbre_Droit, F_Compteur+1);
         end if;
      end if;
   end afficher;

   function ancetrePaternelOrdreN(arbre : in T_Arbre_Bin; genetion : in Integer) is
   begin
   end ancetrePaternelOrdreN;

   function ancetreMaternelOrdreN(arbre : in T_Arbre_Bin; genetion : in Integer) is
   begin
   end ancetreMaternelOrdreN;

   -- Vérifie si les deux arbres sont égaux
   function egaux(F_Individu1, F_Individu2 : in T_Individu) return Boolean is
   begin
      return get_id(F_Arbre1) = get_id(F_Arbre2);
   end egaux;



   procedure afficherUnEntier(F_individu : in indiv.T_Individu) is
   begin
      Put(Integer'Image(F_individu.id));
   end afficherUnEntier;
   procedure afficherIndividu is new afficherIndividuId(afficherId => afficherUnEntier);

   
   --function ancetrePereOrdreN(F_arbre : T_ArbreBin; N : Integer) return T_Individu is
   --begin
      -- à écrire
   --end;

end Arbre_Genealog;
