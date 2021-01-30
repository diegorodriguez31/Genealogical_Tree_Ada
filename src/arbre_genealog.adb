package body Arbre_Genealog is


   -- R0 :Affiche un l'identifiant représenté sous la forme d'un entier
   procedure affichIdentifiant(identifiant : in Integer) is
   begin
      Put("Id: " & Integer'Image(identifiant));
   end affichIdentifiant;

   -- R0 :Indique si l'identifiant représenté sous la forme d'un entier est null
   function nullIdendifiant(identifiant : in Integer) return Boolean is
   begin
      return false; -- Un entier ne peut être null
   end nullIdendifiant;

   -- R0 :Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère
   procedure creer(arbre : in out T_Arbre_Bin ; informations_individu : in T_Informations) is
      individu : T_Individu;
   begin
      -- R1 : Initialiser les numéro d'identifiant
      compteur_identifiant := 1;
      -- R1 : Initialiser l'individu
      individu := creerIndividu(identifiant => compteur_identifiant, informations => informations_individu);
      -- R1 : Initialiser l'arbre
      initialiser(arbre => arbre);
      -- R1 : Ajouter l'individu à l'arbre
      inserer(arbre => arbre, element_precedent => individu, nouvel_element => individu, inserer_a_droite => true);
   end creer;

   -- R0 :Ajouter un parent (mère ou père) à un noeud donné
   procedure ajouterParent(arbre : in out T_Arbre_Bin ; enfant : in T_Individu ; informations_parent : in T_Informations ; parentEstPere : in Boolean) is
      parent : T_Individu;
   begin
      -- R1 : Incrémentation du numéro d'identifiant
      compteur_identifiant := compteur_identifiant + 1;
      -- R1 : Initialiser le parent
      parent := creerIndividu(identifiant => compteur_identifiant, informations => informations_parent);
      -- R1 : Ajouter le parent à l'arbre
      inserer(arbre => arbre, element_precedent => enfant, nouvel_element => parent, inserer_a_droite => parentEstPere);
   exception
      when element_existant =>
         -- R1 : Si un element porte deja ce numero d'identifiant, incrémenter le compteur d'identifiant puis rappeller la fonction
         compteur_identifiant := compteur_identifiant + 1;
         ajouterParent(arbre => arbre, enfant => enfant, informations_parent => informations_parent, parentEstPere => parentEstPere);
      when null_identifiant =>
         -- R1 : Si l'identifiant donné est null, alors initialiser le compteur identifiant avec une valeur arbitraire puis rappeller la fonction
         compteur_identifiant := 100;
         ajouterParent(arbre => arbre, enfant => enfant, informations_parent => informations_parent, parentEstPere => parentEstPere);
   end ajouterParent;

   -- R0 :Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris).
   function obtenirNombreAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu) return Integer is
      sous_arbre : T_Arbre_Bin;
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(arbre => arbre) then
         -- R1 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier les ancêtres d'un arbre null
         raise arbre_null;
      else
         -- R1 : Sinon on recherche le nombre d'ancêtres
         -- R2 : On recherche l'arbre à partir duquel on souhaite chercher le nombre d'ancêtres puis on le stocke dans arbre
         sous_arbre := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         -- R2 : On appelle la fonction "taille" d'un arbre binaire afin de calculer sa taille à partir de l'arbre trouvé
         return taille(arbre => sous_arbre);
      end if;
   end;

   -- R0 :Supprimer, pour un arbre, un noeud et ses ancêtres.
   procedure supprimerNoeudEtAncetres(arbre : in out T_Arbre_Bin ; individu : in T_Individu) is
   begin
      supprimer(arbre => arbre, element => individu);
   end supprimerNoeudEtAncetres;

   -- R0 :Sémantique : Obtenir l'ensemble des individus qui n'ont qu'un parent connu.
   procedure afficherEnsembleUnSeulParent(arbre : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if not estVide(arbre => arbre) then
         -- R2 : si le sous-arbre droit et vide ou exclusif que le sous-arbre gauche aussi
         if estVide(getSousArbreDroit(arbre => arbre)) xor estVide(getSousArbreGauche(arbre)) then
            -- R3 : alors on affiche l'individu courant car il n'a qu'un seul parent connu
            afficherIndividu(individu => getElement(arbre => arbre));
            New_Line;
         else
            -- R3 : sinon on ne fait rien car le noeud ne respecte pas la condition, ce qui n'est pas intéressant à afficher
            null;
         end if;
         begin
            -- R2 : on appelle récursivement la fonction "afficherEnsembleUnSeulParent" à droite afin de parcourir tout l'arbre
            afficherEnsembleUnSeulParent(arbre => getSousArbreDroit(arbre => arbre));
         exception
               -- R3 : Si l'appel récursif lève l'exception arbre null, c'est qu'une feuille est atteinte, il faut continuer
            when arbre_null => null;
         end;
         begin
            -- R2 : on appelle récursivement la fonction "afficherEnsembleUnSeulParent" à gauche afin de parcourir tout l'arbre
            afficherEnsembleUnSeulParent(arbre => getSousArbreGauche(arbre => arbre));
         exception
               -- R3 : Si l'appel récursif lève l'exception arbre null, c'est qu'une feuille est atteinte, il faut continuer
            when arbre_null => null;
         end;
      else
         -- R2 : S'il est vide, alors on lève l'exception arbre_null
         raise arbre_null;
      end if;
   end;

   -- R0 :Obtenir l'ensemble des individus dont les deux parents sont connus.
   procedure afficherEnsembleDeuxParents(arbre : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if not estVide(arbre => arbre) then
         -- R2 : si le sous-arbre droit et vide et que le sous-arbre gauche aussi
         if not estVide(getSousArbreDroit(arbre => arbre)) and not estVide(getSousArbreGauche(arbre)) then
            -- R3 : alors on affiche l'individu courant car il a les deux parents de connus
            afficherIndividu(individu => getElement(arbre => arbre));
            New_Line;
         else
            -- R3 : sinon on ne fait rien car le noeud ne respecte pas la condition, ce qui n'est pas intéressant à afficher
            null;
         end if;
         begin
            -- R3 : on appelle récursivement la fonction "listeDeuxParents" à droite afin de parcourir tout l'arbre
            afficherEnsembleDeuxParents(arbre => getSousArbreDroit(arbre => arbre));
         exception
            when arbre_null => null;
               -- R3 : Si l'appel récursif lève l'exception arbre null, c'est qu'une feuille est atteinte, il faut continuer
         end;
         begin
            -- R3 : on appelle récursivement la fonction "listeDeuxParents" à gauche afin de parcourir tout l'arbre
            afficherEnsembleDeuxParents(arbre => getSousArbreGauche(arbre => arbre));
         exception when
                 arbre_null => null;
               -- R3 : Si l'appel récursif lève l'exception arbre null, c'est qu'une feuille est atteinte, il faut continuer
         end;
      else
         -- R2 : S'il est vide, alors on lève l'exception arbre_null
         raise arbre_null;
      end if;
   end;

   -- R0 :Obtenir l'ensemble des individus dont les deux parents sont inconnus
   procedure afficherEnsembleAucunParent(arbre : in T_Arbre_Bin) is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if not estVide(arbre => arbre) then
         -- R2 : si le sous-arbre droit et vide et que le sous-arbre gauche aussi
         if estVide(getSousArbreDroit(arbre => arbre)) and estVide(getSousArbreGauche(arbre)) then
            -- R3 : alors on affiche l'individu courant car il n'a aucun parent connu
            afficherIndividu(individu => getElement(arbre => arbre));
            New_Line;
         else
            -- R3 : sinon on ne fait rien car le noeud à au moins un parent, ce qui n'est pas intéressant à afficher
            null;
         end if;
         begin
            -- R3 : on appelle récursivement la fonction "listeAucunParent" à droite afin de parcourir tout l'arbre
            afficherEnsembleAucunParent(arbre => getSousArbreDroit(arbre => arbre));
         exception
               -- R3 : Si l'appel récursif lève l'exception arbre null, c'est qu'une feuille est atteinte, il faut continuer
            when arbre_null => null;
         end;
         begin
            -- R3 : on appelle récursivement la fonction "listeAucunParent" à gauche afin de parcourir tout l'arbre
            afficherEnsembleAucunParent(arbre => getSousArbreGauche(arbre => arbre));
         exception
               -- R3 : Si l'appel récursif lève l'exception arbre null, c'est qu'une feuille est atteinte, il faut continuer
            when arbre_null => null;
         end;
      else
         -- R2 : S'il est vide, alors on lève l'exception arbre_null
         raise arbre_null;
      end if;
   end;

   -- R0 :Afficher l'arbre généalogique à partir d'un noeud donné.
   procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin) is
   begin
      afficherArbreGenealogique(arbre => arbre, compteurGenerationRelative => 0);
   end afficherArbreGenealogique;

   -- R0 :Afficher l'arbre généalogique à partir d'un noeud donné.
   procedure afficherArbreGenealogique(arbre : in T_Arbre_Bin ; compteurGenerationRelative : in Integer)is
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(arbre) then
         -- R2 : S'il est vide, on lève l'exception arbre_null
         raise arbre_null;
      else
         -- R2 : Sinon, on affiche l'individu courant
         afficherIndividu(getElement(arbre));
         -- R2 : On vérifie si le sous-arbre gauche est vide
         if estVide(getSousArbreGauche(arbre)) then
            -- R3 : S'il est vide, on ne fait rien
            null;
         else
            -- R3 : Sinon, on boucle jusqu'à atteindre le compteur actuel qui s'incrémente à chaque appel récursif de la procédure
            New_Line;
            for i in 0..compteurGenerationRelative loop
               -- R4 : On ajoute une tabulation pour chaque compteur, cela permet de décaler d'une tabulation l'affichage pour chaque génération
               -- relativement au compteur appelé en paramètre
               Put("    ");
            end loop;
            -- R3 : Une fois la bonne distance de tabulations atteinte, on affiche la mère visuellement
            Put("-- Mere : ");
            -- R3 : On affiche ensuite l'individu avec toutes ses informations
            afficherArbreGenealogique(arbre => getSousArbreGauche(arbre), compteurGenerationRelative => compteurGenerationRelative+1);
         end if;
         if estVide(getSousArbreDroit(arbre)) then
            null;
         else
            New_Line;
            for i in 0..compteurGenerationRelative loop
               -- R4 : On ajoute une tabulation pour chaque compteur, cela permet de décaler d'une tabulation l'affichage pour chaque génération
               -- relativement au compteur appelé en paramètre
               Put("    ");
            end loop;
            -- R3 : Une fois la bonne distance de tabulations atteinte, on affiche le père visuellement
            Put("-- Pere : ");
            -- R3 : On affiche ensuite l'individu avec toutes ses informations
            afficherArbreGenealogique(arbre => getSousArbreDroit(arbre), compteurGenerationRelative => compteurGenerationRelative+1);
         end if;
      end if;
   end afficherArbreGenealogique;

   -- R0 :Obtenir les ancêtres d'une génération donnée pour un noeud donné
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      abr : T_Arbre_Bin;
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(arbre) then
         -- R2 : S'il est vide, on lève l'exception arbre_null
         raise arbre_null;
      else
         -- R2  : Sinon on recherche l'individu dont les anĉetres doivent être affichés
         abr := recherche(arbre => arbre, element =>  individu, retourner_precedent => false);
         -- R3 : On vérifie si l'individu à été trouvé dans l'arbre
         if estVide(abr) then
            -- R4 : S'il est vide, on lève l'exception element_absent
            raise element_absent;
         else
            --R4 : Sinon on affiche le sous arbre pour le nombre de générations donné
            afficherEnsembleAncetres(arbre => abr, generation => generation, compteurGenerationRelative => 0);
         end if;
      end if;
   end afficherEnsembleAncetres;

   -- R0 :Obtenir les ancêtres d'une génération donnée pour un noeud donné.
   procedure afficherEnsembleAncetres(arbre : in T_Arbre_Bin ; generation : in Integer ; compteurGenerationRelative : in Integer) is
      sous_arbre_gauche : T_Arbre_Bin;
      sous_arbre_droit : T_Arbre_Bin;
   begin
      -- R1 : Si le compteur est inférieur ou égal au nombre de génération a traiter
      if generation >= compteurGenerationRelative then
         -- R2 on affiche l'individu courant
         afficherIndividu(individu => getElement(arbre => arbre));
         New_Line;

         --R2 : On affiche les ancêtres du sous arbre gauche s'il n'est pas vide
         sous_arbre_gauche := getSousArbreGauche(arbre => arbre);
         if not estVide(arbre =>  sous_arbre_gauche) then
            afficherEnsembleAncetres(sous_arbre_gauche, generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
         else
            -- R2 : Sinon on ne fait rien
            null;
         end if;
         --R2 : On affiche les ancêtres du sous arbre droit s'il n'est pas vide
         sous_arbre_droit := getSousArbreDroit(arbre => arbre);
         if not estVide(arbre =>  sous_arbre_droit) then
            afficherEnsembleAncetres(sous_arbre_droit,  generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
         else
            -- R2 : Sinon on ne fait rien
            null;
         end if;
      else
         -- R2 : On ne fait rien
         null;
      end if;
   end afficherEnsembleAncetres;

   -- R0 :Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      abr : T_Arbre_Bin;
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(arbre) then
         -- R2 : S'il est vide, on lève l'exception arbre_null
         raise arbre_null;
      else
         -- R2  : Sinon on recherche l'individu dont les anĉetres doivent être affichés
         abr := recherche(arbre => arbre, element =>  individu, retourner_precedent => false);
         -- R2 : On vérifie si l'individu à été trouvé dans l'arbre
         if estVide(abr) then
            -- R3 : S'il est vide, on lève l'exception element_absent
            raise element_absent with "l'individu donné n'existe pas";
         else
            -- R3 : Sinon on affiche les ancêtres de la génération donnée
            afficherEnsembleAncetresGenerationUnique(arbre => abr, generation => generation, compteurGenerationRelative => 0);
         end if;
      end if;
   end afficherEnsembleAncetresGenerationUnique;

   -- R0 :Semantique : Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné.
   procedure afficherEnsembleAncetresGenerationUnique(arbre : in T_Arbre_Bin ; generation : in Integer ; compteurGenerationRelative : in Integer)is
      sous_arbre_gauche : T_Arbre_Bin;
      sous_arbre_droit : T_Arbre_Bin;
   begin
      -- R1 : Sinon on vérifie si le compteur (que je fais démarrer de 0 dans le menu appelant cette procedure) est égal à la génération recherchée
      if generation = compteurGenerationRelative then
         -- R2 : Si oui, alors on est dans la bonne lignée d'ancêtres, on affiche donc l'individu
         afficherIndividu(individu => getElement(arbre => arbre));
         New_Line;
      else
         -- R1 : Sinon, si le nmbre de génération parcourue est inférieur au nombre de génération demandé
         if compteurGenerationRelative < generation then
            -- R2 : On appelle récursivement l'arbre gauche puis l'arbre droit pour parcourir tout l'arbre s'ils ne sont pas vides
            sous_arbre_gauche := getSousArbreGauche(arbre => arbre);
            if not estVide(arbre =>  sous_arbre_gauche) then
               afficherEnsembleAncetresGenerationUnique(sous_arbre_gauche, generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
            else
               -- R3 : Sinon on ne fait rien
               null;
            end if;
            sous_arbre_droit := getSousArbreDroit(arbre => arbre);
            if not estVide(arbre =>  sous_arbre_droit) then
               afficherEnsembleAncetresGenerationUnique(sous_arbre_droit,  generation => generation, compteurGenerationRelative => compteurGenerationRelative +1);
            else
               -- R3 : Sinon on ne fait rien
               null;
            end if;
         else
            -- R2 : Sinon on ne fait rien
            null;
         end if;
      end if;
   end afficherEnsembleAncetresGenerationUnique;

   -- R0 :Identifier les descendants d'une génération donnée pour un noeud donné.
   procedure afficherEnsembleDescendantsGenerationUnique(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer) is
      individu_recherche : T_Arbre_Bin;
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(arbre) then
         -- R2 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier le descendant d'un arbre null
         raise arbre_null;
      else
         -- R2 : Sinon, on recherche l'individu dont les descendants doivent être affichés
         individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         if estVide(individu_recherche) then
            --R3 : Si l'individu n'est pas présent alors lever l'exception element_absent
            raise element_absent;
         else
            -- R3 : Sinon afficher le descendant recherché
            begin
               -- R4 : Rechercher l'ancêtre de l'element acutel 'generation' fois
               for generation_parcourue in 1..generation loop
                  individu_recherche := recherche(arbre => arbre, element => getElement(individu_recherche), retourner_precedent => true);
               end loop;
               -- R4 : Afficher l'ancêtre s'il est trouvé
               afficherIndividu(getElement(individu_recherche));
               New_Line;
            exception
                  -- R4 : Si l'ancêtre n'est pas trouvé, ne rien faire !
               when arbre_null => null;
            end;
         end if;
      end if;
   end;

   -- R0 :Obtenir la succession de descendants d'une génération donnée pour un noeud donné
   procedure afficherEnsembleDescendants(arbre : in T_Arbre_Bin ; individu : in T_Individu ; generation : in Integer)is
      generation_parcourue : Integer := 0;
      individu_recherche : T_Arbre_Bin;
   begin
      -- R1 : On vérifie si l'arbre est vide
      if estVide(arbre) then
         -- R2 : S'il est vide, alors on lève l'exception arbre_null pour indiquer qu'on ne peut pas identifier le descendant d'un arbre null
         raise arbre_null;
      else
         -- R2 : Sinon, on recherche l'individu dont les descendants doivent être affichés
         individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => false);
         if estVide(individu_recherche) then
            --R3 : Si l'individu n'est pas présent alors lever l'exception element_absent
            raise element_absent;
         else
            -- R4 : Rechercher l'ancêtre de l'element acutel 'generation' fois
            individu_recherche := recherche(arbre => arbre, element => individu, retourner_precedent => true);
            while generation_parcourue <= generation and not estVide(individu_recherche) loop
               generation_parcourue := generation_parcourue +1;
               -- R4 : Afficher l'ancêtre
               afficherIndividu(getElement(individu_recherche));
               New_Line;
               begin
                  -- R4 : Rechercher l'ancêtre de l'element acutel 'generation' fois
                  individu_recherche := recherche(arbre => arbre, element => getElement(individu_recherche), retourner_precedent => true);
               exception
                     -- lorsque la racine de l'arbre est atteinte, rechercher l'element précédent génère une exception
                  when element_absent =>
                     -- R4 : Quand il n'y a plus d'ancêtres, arrêter la recherche
                     generation_parcourue := generation +1;
               end;
            end loop;
         end if;
      end if;
   end afficherEnsembleDescendants;

end Arbre_Genealog;
