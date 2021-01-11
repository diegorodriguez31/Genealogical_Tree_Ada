with arbre_bin;

package body arbre_genealog is

   package arbre_genealogique is new Arbre_Bin(T_Element => T_Individu);
   use arbre_genealogique;

   -- Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   function creer(F_Individu : in T_Individu) return T_Arbre_Gen is
      arbre : T_Arbre_Bin;
   begin
      arbre := arbre_genealogique.creer(F_Individu);
      return arbre;
   end creer;

   -- Ajouter un parent à un noeud donné
   procedure ajouterParent(Id : in T_Id ; Parent : in T_Arbre_Gen ; PereOuMere : in Boolean) is
      begin
   end ajouterParent;

   -- Ajoute un père à un noeud donné
   procedure ajouterPere(arbre : T_Arbre_Bin, pere : T_Individu) is
   begin
      arbre_genealogique.inserer(arbre, null, pere, true);
   end ajouterPere;

   -- Ajoute un mère à un noeud donné
   procedure ajouterMere(arbre : T_Arbre_Bin, mere : T_Individu) is
   begin
      arbre_genealogique.inserer(arbre, null, mere, true);
   end ajouterMere;


   -- Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris)
function nombreAncetres(Id : in T_Id) return Integer is
      begin
   end nombreAncetres;

   --Identifier les ancêtres d'une génération donnée pour un noeud donné
   procedure identifierAncetres(Id : in T_Id ; Generation : in Integer) is
         begin
   end identifierAncetres;

   -- Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné
   procedure ensembleAncetres(Id : in T_Id ; Generation : in Integer) is
         begin
   end ensembleAncetres;

   -- Identifier les descendants d'une génération donnée pour un noeud donné
   procedure identifierDescendants(Id : in T_Id ; Generation : in Integer) is
         begin
   end identifierDescendants;

   -- Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   procedure ensembleDescendants(Id : in T_Id ; Generation : in Integer) is
         begin
   end ensembleDescendants;

   -- Afficher l'arbre à partir d'un noeud donné
   procedure afficherArbreGen(Id : in T_Id) is
         begin
   end afficherArbreGen;

   -- Supprimer, pour un arbre, un noeud et ses ancêtres
   procedure supprimerNoeudEtAncetres(Id : in T_Id) is
      begin
   end supprimerNoeudEtAncetres;

   -- Obtenir l'ensemble des individus qui n'ont qu'un parent connu
   procedure listeUnSeulParent(arbre : in T_Arbre_Gen) is
         begin
   end listeUnSeulParent;

   -- Obtenir l'ensemble des individus dont les deux parents sont connus
   procedure listeDeuxParents(arbre : in T_Arbre_Gen) is
         begin
   end listeDeuxParents;

   -- Obtenir l'ensemble des individus dont les deux parents sont inconnus
   procedure listeAucunParent(arbre : in T_Arbre_Gen) is
         begin
   end listeAucunParent;

   -- Affiche l'arbre généalogique
   procedure afficher(arbre : in T_ArbreGen;  compteur : Integer) is
   begin
      if estVide(arbre) then
         null;
      else
         --afficherDonneeId(arbre.all.donnee.id);

         if estVide(arbre.all.Sous_Arbre_Gauche) then
            null;
         else
            New_Line;
            for j in 0..compteur loop
               Put("    ");
            end loop;
            Put("-- pere : ");
            afficher(arbre.all.Sous_Arbre_Gauche, compteur+1);
         end if;
         if estVide(arbre.all.Sous_Arbre_Droit) then
            null;
         else
            New_Line;
            for j in 0..compteur loop
               Put("    ");
            end loop;
            Put("-- mere : ");
            afficher(arbre.all.Sous_Arbre_Droit, compteur+1);
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
   function egaux(F_Arbre1, F_Arbre2 : in T_Arbre_Bin) return Boolean is
   begin
      return get_id(F_Arbre1) = get_id(F_Arbre2);
   end egaux;


end Arbre_Genealog;
