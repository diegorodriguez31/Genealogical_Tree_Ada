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
   procedure creer(arbre : in out T_Arbre_Bin ; informations_individu : in T_Informations) is
      individu : T_Individu;
   begin
      compteur_identifiant := 1;
      individu := creerIndividu(identifiant => compteur_identifiant, informations => informations_individu);
      initialiser(arbre => arbre);
      inserer(arbre => arbre, element_precedent => individu, nouvel_element => individu, inserer_a_droite => true);
   end creer;

   -- Ajouter un parent (mère ou père) à un noeud donné
   procedure ajouterParent(arbre : in out T_Arbre_Bin ; enfant : in T_Individu ; informations_parent : in T_Informations ; parentEstPere : in Boolean) is
      parent : T_Individu;
   begin
      compteur_identifiant := compteur_identifiant + 1;
      parent := creerIndividu(identifiant => compteur_identifiant, informations => informations_parent);
      inserer(arbre => arbre, element_precedent => enfant, nouvel_element => parent, inserer_a_droite => parentEstPere);
   exception
      when element_existant =>
         compteur_identifiant := compteur_identifiant + 1;
         ajouterParent(arbre => arbre, enfant => enfant, informations_parent => informations_parent, parentEstPere => parentEstPere);
      when null_identifiant =>
         compteur_identifiant := 100;
         parent := creerIndividu(identifiant => compteur_identifiant, informations => informations_parent);
         inserer(arbre => arbre, element_precedent => enfant, nouvel_element => parent, inserer_a_droite => parentEstPere);
   end ajouterParent;

   -- Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris).
   function obtenirNombreAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu) return Integer is
      sous_arbre : T_Arbre_Bin;
   begin
      if estVide(arbre => arbre) then
         raise arbre_null;
      else

         sous_arbre := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         return taille(arbre => sous_arbre);
      end if;
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
            New_Line;
         else
            null;
         end if;
         begin
            afficherEnsembleUnSeulParent(arbre => getSousArbreDroit(arbre => arbre));
         exception when arbre_null => null;
         end;
         begin
            afficherEnsembleUnSeulParent(arbre => getSousArbreGauche(arbre => arbre));
         exception when arbre_null => null;
         end;
      else
         raise arbre_null;
      end if;
   end;

   -- Obtenir l'ensemble des individus dont les deux parents sont connus.
   procedure afficherEnsembleDeuxParents(arbre : in T_Arbre_Bin) is
   begin
      if not estVide(arbre => arbre) then
         if not estVide(getSousArbreDroit(arbre => arbre)) and not estVide(getSousArbreGauche(arbre)) then
            afficherIndividu(individu => getElement(arbre => arbre));
            New_Line;
         else
            null;
         end if;
         begin
            afficherEnsembleDeuxParents(arbre => getSousArbreDroit(arbre => arbre));
         exception when arbre_null => null;
         end;
         begin
            afficherEnsembleDeuxParents(arbre => getSousArbreGauche(arbre => arbre));
         exception when arbre_null => null;
         end;
      else
         raise arbre_null;
      end if;
   end;

   -- Obtenir l'ensemble des individus dont les deux parents sont inconnus
   procedure afficherEnsembleAucunParent(arbre : in T_Arbre_Bin) is
   begin
      if not estVide(arbre => arbre) then
         if estVide(getSousArbreDroit(arbre => arbre)) and estVide(getSousArbreGauche(arbre)) then
            afficherIndividu(individu => getElement(arbre => arbre));
            New_Line;
         else
            null;
         end if;
         begin
            afficherEnsembleAucunParent(arbre => getSousArbreDroit(arbre => arbre));
         exception when arbre_null => null;
         end;
         begin
            afficherEnsembleAucunParent(arbre => getSousArbreGauche(arbre => arbre));
         exception when arbre_null => null;
         end;
      else
         raise arbre_null;
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
         raise arbre_null;
      else
         afficherIndividu(getElement(arbre));
         if estVide(getSousArbreGauche(arbre)) then
            null;
         else
            New_Line;
            for i in 0..compteurGenerationRelative loop
               Put("    ");
            end loop;
            Put("-- Mere : ");
            afficherArbreGenealogique(arbre => getSousArbreGauche(arbre), compteurGenerationRelative => compteurGenerationRelative+1);
         end if;
         if estVide(getSousArbreDroit(arbre)) then
            null;
         else
            New_Line;
            for i in 0..compteurGenerationRelative loop
               Put("    ");
            end loop;
            Put("-- Pere : ");
            afficherArbreGenealogique(arbre => getSousArbreDroit(arbre), compteurGenerationRelative => compteurGenerationRelative+1);
         end if;
      end if;
   end afficherArbreGenealogique;

   -- Obtenir les ancêtres d'une génération donnée pour un noeud donné
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      abr : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null;
      else
         abr := recherche(arbre => arbre, element =>  individu, retourner_precedent => false);
         if estVide(abr) then
            raise element_absent;
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
      if generation <= compteurGenerationRelative then
         afficherIndividu(individu => getElement(arbre => arbre));
         New_Line;
      else
         null;
      end if;
      sous_arbre_gauche := getSousArbreGauche(arbre => arbre);
      if not estVide(arbre =>  sous_arbre_gauche) then
         afficherEnsembleAncetres(sous_arbre_gauche, generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
      else
         null;
      end if;
      sous_arbre_droit := getSousArbreDroit(arbre => arbre);
      if not estVide(arbre =>  sous_arbre_droit) then
         afficherEnsembleAncetres(sous_arbre_droit,  generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
      else
         null;
      end if;
   end afficherEnsembleAncetres;

   -- Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      abr : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null;
      else
         abr := recherche(arbre => arbre, element =>  individu, retourner_precedent => false);
         if estVide(abr) then
            raise element_absent with "l'individu donné n'existe pas";
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
         New_Line;
      else
         if compteurGenerationRelative < generation then
            sous_arbre_gauche := getSousArbreGauche(arbre => arbre);
            if not estVide(arbre =>  sous_arbre_gauche) then
               afficherEnsembleAncetresGenerationUnique(sous_arbre_gauche, generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
            else
               null;
            end if;
            sous_arbre_droit := getSousArbreDroit(arbre => arbre);
            if not estVide(arbre =>  sous_arbre_droit) then
               afficherEnsembleAncetresGenerationUnique(sous_arbre_droit,  generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
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
      if estVide(arbre) then
         raise arbre_null;
      else
         individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         if estVide(individu_recherche) then
            raise element_absent;
         else
            begin
            for generation_parcourue in 1..generation loop
               individu_recherche := recherche(arbre => arbre, element => getElement(individu_recherche), retourner_precedent => true);
            end loop;
            afficherIndividu(getElement(individu_recherche));
            New_Line;
            exception
               when arbre_null => null;
            end;
         end if;
      end if;
   end;

   -- Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   procedure afficherEnsembleDescendants(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer)is
      generation_parcourue : Integer := 0;
      individu_recherche : T_Arbre_Bin;
   begin
      if estVide(arbre) then
         raise arbre_null;
      else
         individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         if estVide(individu_recherche) then
            raise element_absent;
         else
            individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => true);
            while generation_parcourue <= generation and not estVide(individu_recherche) loop
               generation_parcourue := generation_parcourue +1;
               afficherIndividu(getElement(individu_recherche));
               New_Line;
               begin
                  individu_recherche := recherche(arbre => arbre, element => getElement(individu_recherche), retourner_precedent => true);
               exception
                     -- lorsque la racine de l'arbre est atteinte, rechercher l'element précédent génère une exception
                  when element_absent => generation_parcourue := generation +1;

               end;
            end loop;
         end if;
      end if;
   end afficherEnsembleDescendants;

end Arbre_Genealog;
