package body Arbre_Genealog is


   --Indique comment afficher l'identifiant d'un individu
   procedure affichIdentifiant(identifiant : in Integer) is
   begin
      Put(Integer'Image(identifiant));
   end affichIdentifiant;

   function nullIdendifiant(identifiant : in Integer) return Boolean is
   begin
      return false; -- Un entier ne peut être null
   end nullIdendifiant;


   -- Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   procedure creer(arbre : in out T_Arbre_Bin ; individu : in T_Individu) is
   begin
      initialiser(arbre => arbre);
      inserer(arbre => arbre, element_precedent => individu, nouvel_element => individu, inserer_a_droite => true);
   end creer;

   -- Ajouter un parent (mère ou père) à un noeud donné
   procedure ajouterParent(arbre : in out T_Arbre_Bin ; enfant : in T_Individu ; parent : in T_Individu ; parentEstPere : in Boolean) is
   begin
      inserer(arbre => arbre, element_precedent => enfant, nouvel_element => parent, inserer_a_droite => parentEstPere);
   end ajouterParent;

   -- Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris).
   function afficherNombreAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu) return Integer is
      sous_arbre : T_Arbre_Bin;
   begin
      sous_arbre := recherche(arbre => arbre, element => individu, retourner_precedent => false);
      return taille(arbre => sous_arbre);
   end;

   -- Supprimer, pour un arbre, un noeud et ses ancêtres.
   procedure supprimerNoeudEtAncetres(arbre : in out T_Arbre_Bin ; individu : in T_Individu) is
   begin
      supprimer(arbre => arbre, element => individu);
   end supprimerNoeudEtAncetres;

   -- Sémantique : Obtenir l'ensemble des individus qui n'ont qu'un parent connu.
   procedure afficherEnsembleUnSeulParent(arbre : in T_Arbre_Bin) is
   begin
      if not estVide(arbre => arbre) then
         if estVide(getSousArbreDroit(arbre => arbre)) xor estVide(getSousArbreGauche(arbre)) then
            afficherIndividu(individu => getElement(arbre => arbre));
         else
            null;
         end if;
         afficherEnsembleUnSeulParent(arbre => getSousArbreDroit(arbre => arbre));
         afficherEnsembleUnSeulParent(arbre => getSousArbreGauche(arbre => arbre));
      else
         null;
      end if;
   end;

   -- Obtenir l'ensemble des individus dont les deux parents sont connus.
   procedure afficherEnsembleDeuxParents(arbre : in T_Arbre_Bin) is
   begin
      if not estVide(arbre => arbre) then
         if not estVide(getSousArbreDroit(arbre => arbre)) and not estVide(getSousArbreGauche(arbre)) then
            afficherIndividu(individu => getElement(arbre => arbre));
         else
            null;
         end if;
         afficherEnsembleDeuxParents(arbre => getSousArbreDroit(arbre => arbre));
         afficherEnsembleDeuxParents(arbre => getSousArbreGauche(arbre => arbre));
      else
         null;
      end if;
   end;

   -- Obtenir l'ensemble des individus dont les deux parents sont inconnus
   procedure afficherEnsembleAucunParent(arbre : in T_Arbre_Bin) is
   begin
      if not estVide(arbre => arbre) then
         if estVide(getSousArbreDroit(arbre => arbre)) and estVide(getSousArbreGauche(arbre)) then
            afficherIndividu(individu => getElement(arbre => arbre));
         else
            null;
         end if;
         afficherEnsembleAucunParent(arbre => getSousArbreDroit(arbre => arbre));
         afficherEnsembleAucunParent(arbre => getSousArbreGauche(arbre => arbre));
      else
         null;
      end if;
   end;

   -- Afficher l'arbre généalogique à partir d'un noeud donné.
   procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin) is
   begin
      afficherArbreGenealogique(arbre => arbre, compteurGenerationRelative => 0);
   end afficherArbreGenealogique;

   -- Afficher l'arbre généalogique à partir d'un noeud donné.
   procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin ; compteurGenerationRelative : in Integer)is
   begin
      if estVide(arbre) then
         null;
      else
         afficherIndividu(getElement(arbre));
         if estVide(getSousArbreGauche(arbre)) then
            null;
         else
            New_Line;
            for i in 0..compteurGenerationRelative loop
               Put("    ");
            end loop;
            Put("-- Père : ");
            afficherArbreGenealogique(arbre => arbre, compteurGenerationRelative => compteurGenerationRelative+1);
         end if;
         if estVide(getSousArbreDroit(arbre)) then
            null;
         else
            New_Line;
            for i in 0..compteurGenerationRelative loop
               Put("    ");
            end loop;
            Put("-- Mère : ");
            afficherArbreGenealogique(arbre => arbre, compteurGenerationRelative => compteurGenerationRelative+1);
         end if;
      end if;
   end afficherArbreGenealogique;

   -- Obtenir les ancêtres d'une génération donnée pour un noeud donné
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      abr : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null with "Arbre null";
      else
         abr := recherche(arbre => arbre, element =>  individu, retourner_precedent => false);
         if estVide(abr) then
            raise individu_inexistant with "l'individu donné n'existe pas";
         else
            afficherEnsembleAncetres(arbre => abr, generation => generation, compteurGenerationRelative => 0);
         end if;
      end if;
   end afficherEnsembleAncetres;

   -- Obtenir les ancêtres d'une génération donnée pour un noeud donné.
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; generation : in Integer ; compteurGenerationRelative : in Integer) is
      sous_arbre_gauche : T_Arbre_Bin;
      sous_arbre_droit : T_Arbre_Bin;
   begin
      afficherIndividu(individu => getElement(arbre => arbre));
      if compteurGenerationRelative < generation then
         sous_arbre_gauche := getSousArbreGauche(arbre => arbre);
         if not estVide(arbre =>  sous_arbre_gauche) then
            afficherEnsembleAncetres(sous_arbre_gauche, generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
         else
            null;
         end if;
         sous_arbre_droit := getSousArbreGauche(arbre => arbre);
         if not estVide(arbre =>  sous_arbre_droit) then
            afficherEnsembleAncetres(sous_arbre_droit,  generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
         else
            null;
         end if;
      else
         null;
      end if;
   end afficherEnsembleAncetres;

   -- Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      abr : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null with "Arbre null";
      else
         abr := recherche(arbre => arbre, element =>  individu, retourner_precedent => false);
         if estVide(abr) then
            raise individu_inexistant with "l'individu donné n'existe pas";
         else
            afficherEnsembleAncetresGenerationUnique(arbre => abr, generation => generation, compteurGenerationRelative => 0);
         end if;
      end if;
   end afficherEnsembleAncetresGenerationUnique;

   -- Semantique : Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; generation : in Integer ; compteurGenerationRelative : in Integer)is
      sous_arbre_gauche : T_Arbre_Bin;
      sous_arbre_droit : T_Arbre_Bin;
   begin
      if generation = compteurGenerationRelative then
        afficherIndividu(individu => getElement(arbre => arbre));
      else
         if compteurGenerationRelative < generation then
            sous_arbre_gauche := getSousArbreGauche(arbre => arbre);
            if not estVide(arbre =>  sous_arbre_gauche) then
               afficherEnsembleAncetres(sous_arbre_gauche, generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
            else
               null;
            end if;
            sous_arbre_droit := getSousArbreGauche(arbre => arbre);
            if not estVide(arbre =>  sous_arbre_droit) then
               afficherEnsembleAncetres(sous_arbre_droit,  generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
            else
               null;
            end if;
         else
            null;
         end if;
      end if;
   end afficherEnsembleAncetresGenerationUnique;

   --  Identifier les descendants d'une génération donnée pour un noeud donné.
   procedure afficherEnsembleDescendantsGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      individu_recherche : T_Arbre_Bin;
   begin
      individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => false);
      for generation_parcourue in 1..generation loop
         individu_recherche := recherche(arbre => arbre, element => getElement(individu_recherche), retourner_precedent => true);
      end loop;
      afficherIndividu(getElement(individu_recherche));
   end;

   -- Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   procedure afficherEnsembleDescendants(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer)is
      generation_parcourue : Integer := 0;
      individu_recherche : T_Arbre_Bin;
   begin
      if estVide(arbre => arbre) then
         raise arbre_null;
      else
         individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         if estVide(individu_recherche) then
            raise individu_inexistant;
         else
            while generation_parcourue <= generation and not  estVide(individu_recherche) loop
               afficherIndividu(getElement(individu_recherche));
               individu_recherche := recherche(arbre => arbre, element => getElement(individu_recherche), retourner_precedent => true);
            end loop;
         end if;
      end if;
   end afficherEnsembleDescendants;

end Arbre_Genealog;
