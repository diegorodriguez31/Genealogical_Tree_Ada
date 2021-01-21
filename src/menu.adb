with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package body menu is

   procedure afficherMenu is
   begin
      New_Line;
      New_Line;
      Put("##############################################");
      New_Line;
      Put_Line("                           MANIPULATION D'UN ARBRE GÉNÉALOGIQUE              ");
      Put_Line("Que voulez-vous faire ?");
      New_Line;
      Put_Line("    1) Créer un arbre minimal coutenant le seul noeud racine, sans père ni mère");
      Put_Line("    2) Ajouter un père à un noeud donné");
      Put_Line("    3) Ajouter une mère à un noeud donné");
      Put_Line("    4) Obtenir le nombre d'ancêtres connus d'un individu donné (lui compris)");
      Put_Line("    5) Identifier les ancêtres d'une génération donnée pour un noeud donné");
      Put_Line("    6) Obtenir l'ensemble des ancêtres situés à une certaine génération d'un noeud donné");
      Put_Line("    7) Identifier les descendants d'une génération donnée pour un noeud donné");
      Put_Line("    8) Obtenir la succession de descendants d'une génération donnée pour un noeud donné");
      Put_Line("    9) Afficher l'arbre généalogique à partir d'un noeud donné");
      Put_Line("    10) Supprimer, pour un arbre, un noeud et ses ancêtres");
      Put_Line("    11) Modifier partièlement un individu");
      Put_Line("    12) Modifier totalement un individu");
      Put_Line("    13) Obtenir l'ensemble des individus dont les deux parents sont inconnus");
      Put_Line("    14) Obtenir l'ensemble des individus qui n'ont qu'un parent connu");
      Put_Line("    15) Obtenir l'ensemble des individus dont les deux parents sont connus");
      Put_Line("    16) Obtenir l'ancêtre paternel d'une génération donnée");
      Put_Line("    17) Obtenir l'ancêtre maternel d'une génération donnée");
      New_Line;
      Put_Line("                                  COMMANDES UTILES                            ");
      New_Line;
      Put_Line("    18) Afficher l'arbre généalogique entièrement");
      Put_Line("    19) Créer un arbre prérempli");
      Put_Line("    0) Quitter");
      New_Line;
      Put("##############################################");
      New_Line;
      New_Line;
   end afficherMenu;

   procedure commande_1_creer_arbre(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
   begin
      Put_Line("=> Saisissez un identifiant : ");
      Get(id);
      creer(F_Arbre, individu_Integer.creerIndividu(id));
   end commande_1_creer_arbre;

   procedure commande_2_ajouter_pere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
      arbre : arbre_genealogique.T_Arbre_Bin;
   begin
      Put_Line("=> À qui ajouter le père ?");
      Get(id);
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      loop
         Put_Line("=> Quel identifiant pour ce père ?");
         Get(id);
         exit when not arbre_genealogique.existe(F_Arbre, individu_Integer.creerIndividu_Id(id));
         New_Line;
         Put_Line("/!\ Individu déjà existant /!\");
         New_Line;
      end loop;
      ajouterPere(arbre, individu_Integer.creerIndividu_Id(id));
      New_Line;
      Put_Line("=> PÈRE AJOUTÉ AVEC SUCCÈS !");
      New_Line;
   end commande_2_ajouter_pere;

   procedure commande_3_ajouter_mere(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
      arbre : arbre_genealogique.T_Arbre_Bin;
   begin
      Put_Line("=> À qui ajouter la mère ?");
      Get(id);
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      loop
         Put_Line("=> Quel identifiant pour cette mère ?");
         Get(id);
         exit when not arbre_genealogique.existe(F_Arbre, individu_Integer.creerIndividu_Id(id));
         New_Line;
         Put_Line("/!\ Individu déjà existant /!\");
         New_Line;
      end loop;
      ajouterMere(arbre, individu_Integer.creerIndividu_Id(id));
      New_Line;
      Put_Line("=> MÈRE AJOUTÉ AVEC SUCCÈS !");
      New_Line;
   end commande_3_ajouter_mere;


   procedure commande_4_nombre_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
      nb_ancetres : Integer;
   begin
      Put_Line("=> De quel individu voulez-vous le nombre d'ancêtres ?");
      Get(id);
      nb_ancetres := nombreAncetres(F_Arbre, individu_Integer.creerIndividu_Id(id));
      Put("=> L'individu" & Integer'Image(id) & " a" & Integer'Image(nb_ancetres) & " ancêtres, lui compris.");
   end commande_4_nombre_ancetres;

   procedure commande_5_identifier_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      id : Integer;
      generation : Integer;
      compteur : Integer := 0;
   begin
      Put_Line("=> De quel individu recherchez-vous les ancêtres ?");
      Get(id);
      Put_Line("=> À quelle génération par rapport à cet individu voulez-vous rechercher ses ancêtres ?");
      Get(generation);
      if generation = 0 then
         Put_Line("=> L'individu n'a pas d'ancêtre pour la génération 0 (cela correspond à lui-même)");
      else
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         Put_Line("=> Voici les ancêtres de l'individu"  & Integer'Image(id) & ":");
         identifierAncetres(arbre, generation, compteur);
      end if;
   end commande_5_identifier_ancetres;

   procedure commande_6_ensemble_ancetres(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      id : Integer;
      generation : Integer;
      compteur : Integer := 0;
   begin
      Put_Line("=> De quel individu recherchez-vous les ancêtres ?");
      Get(id);
      Put_Line("=> À quelle génération par rapport à cet individu voulez-vous rechercher l'ensemble de ses ancêtres ?");
      Get(generation);
      if generation = 0 then
         Put_Line("=> L'individu n'a pas d'ancêtre pour la génération 0 (cela correspond à lui-même)");
      else
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         Put_Line("=> Voici l'ensemble des ancêtres de l'individu" & Integer'Image(id) & ":");
         ensembleAncetres(arbre, generation, compteur);
      end if;
   end commande_6_ensemble_ancetres;

   procedure commande_7_identifier_descendants(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      id : Integer;
      generation : Integer;
      compteur : Integer := 0;
   begin
      Put_Line("=> De quel individu recherchez-vous les descendants ?");
      Get(id);
      Put_Line("=> À quelle génération par rapport à cet individu voulez-vous rechercher ses descendants ?");
      Get(generation);
      if generation = 0 then
         Put_Line("=> L'individu n'a pas de descendant pour la génération 0 (cela correspond à lui-même)");
      else
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         Put_Line("=> Voici les descendants de l'individu"  & Integer'Image(id) & " :");
         identifierDescendants(F_arbre, arbre, generation, compteur);
      end if;
   end commande_7_identifier_descendants;

   procedure commande_8_ensemble_descendants(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      id : Integer;
      generation : Integer;
      compteur : Integer := 0;
   begin
      Put_Line("=> De quel individu recherchez-vous les descendants ?");
      Get(id);
      Put_Line("=> À quelle génération par rapport à cet individu voulez-vous rechercher l'ensemble de ses descendants ?");
      Get(generation);
      if generation = 0 then
         Put_Line("=> L'individu n'a pas de descendant pour la génération 0 (cela correspond à lui-même)");
      else
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         Put_Line("=> Voici les descendants de l'individu" & Integer'Image(id) & " :");
         ensembleDescendants(F_Arbre, arbre, generation, compteur);
      end if;
   end commande_8_ensemble_descendants;

   procedure commande_9_afficher(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
      arbre : arbre_genealogique.T_Arbre_Bin;
   begin
      Put_Line("=> Quel est l'individu racine de l'arbre ?");
      Get(id);
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      New_Line;
      Put_Line("☐☐☐☐☐☐☐☐☐☐☐☐☐☐☐");
      afficherArbreGen(arbre, 0);
      New_Line;
      Put_Line("☐☐☐☐☐☐☐☐☐☐☐☐☐☐☐");
   end commande_9_afficher;

   procedure commande_10_supprimer_branche(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
   begin
      Put_Line("=> Quel individu voulez-vous supprimer ? Attention, cela supprimera aussi ses ancêtres");
      Get(id);
      supprimerNoeudEtAncetres(F_Arbre, individu_Integer.creerIndividu_Id(id));
      New_Line;
      Put_Line("=> INDIVIDU SUPPRIMÉ AVEC SUCCÈS !");
      New_Line;
   end commande_10_supprimer_branche;

   procedure commande_11_modifier_individu(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
      arbre : arbre_genealogique.T_Arbre_Bin;
      informations : individu_Integer.PT_Informations;
      individu_source : individu_Integer.T_Individu;
      individu_cible : individu_Integer.T_Individu;
      choix : Integer;
      nom : Unbounded_String;
      prenom : Unbounded_String;
      sexe : Unbounded_String;
      date_naissance : Unbounded_String;
      date_deces : Unbounded_String;
      adresse : Unbounded_String;

   begin
      Put_Line("=> Quel individu voulez-vous modifier ?");
      Get(id);
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      individu_source := arbre_genealogique.getElement(arbre);
      individu_cible := individu_Integer.creerIndividu_Id(id);
      individu_cible.Informations := individu_source.Informations;
      informations := individu_Integer.get_informations(individu_cible);
      if not (individu_Integer.estNul(informations)) then
         loop
            Put_Line("=> Quelles valeurs voulez-vous modifier ?");
            Put_Line("      NOM => Tapez 1");
            Put_Line("      PRÉNOM => Tapez 2");
            Put_Line("      SEXE => Tapez 3");
            Put_Line("      DATE DE NAISSANCE => Tapez 4");
            Put_Line("      DATE DE DÉCÈS => Tapez 5");
            Put_Line("      ADRESSE => Tapez 6");
            Get(choix);
            exit when choix > 0 and choix < 7;
         end loop;
         case choix is
         when 1 =>
            Put_Line("Veuillez indiquer le nouveau nom :");
            Skip_Line;
            Get_Line(nom);
            informations.all.Nom := nom;
         when 2 =>
            Put_Line("Veuillez indiquer le nouveau prenom :");
            Get_Line(prenom);
            Skip_Line;
            informations.all.Prenom := prenom;
         when 3 =>
            Put_Line("Veuillez indiquer le nouveau sexe :");
            Get_Line(sexe);
            Skip_Line;
            informations.all.Sexe := sexe;
         when 4 =>
            Put_Line("Veuillez indiquer la nouvelle date de naissance :");
            Get_Line(date_naissance);
            Skip_Line;
            informations.all.Date_Naissance := date_naissance;
         when 5 =>
            Put_Line("Veuillez indiquer la nouvelle date de décès :");
            Get_Line(date_deces);
            Skip_Line;
            informations.all.Date_Deces := date_deces;
         when 6 =>
            Put_Line("Veuillez indiquer la nouvelle adresse :");
            Get_Line(adresse);
            Skip_Line;
            informations.all.Adresse := adresse;
         when others => null;
         end case;
      else
         null;
      end if;
      individu_cible.Informations := informations;
      modifierIndividu(F_Arbre, individu_source, individu_cible);
      New_Line;
      Put_Line("=> INDIVIDU MODIFIÉ AVEC SUCCÈS !");
      New_Line;
   end commande_11_modifier_individu;

   procedure commande_12_modifier_totalement_individu(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      id : Integer;
      arbre : arbre_genealogique.T_Arbre_Bin;
      individu_source : individu_Integer.T_Individu;
      individu_cible : individu_Integer.T_Individu;
   begin
      Put_Line("=> Quel individu voulez-vous modifier ?");
      Get(id);
      arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
      individu_source := arbre_genealogique.getElement(arbre);
      individu_cible := individu_Integer.creerIndividu(id);
      modifierIndividu(F_Arbre, individu_source, individu_cible);
      New_Line;
      Put_Line("=> INDIVIDU MODIFIÉ AVEC SUCCÈS !");
      New_Line;
   end commande_12_modifier_totalement_individu;

   procedure commande_13_aucun_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      Put_Line("=> Les individus qui n'ont aucun parent connu sont : ");
      listeAucunParent(F_Arbre);
   end commande_13_aucun_parent_connu;

   procedure commande_14_un_parent_connu(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      Put_Line("=> Les individus qui n'ont qu'un seul parent connu sont : ");
      listeUnSeulParent(F_Arbre);
   end commande_14_un_parent_connu;

   procedure commande_15_deux_parents_connus(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      Put_Line("=> Les individus qui ont les deux parents connus sont : ");
      listeDeuxParents(F_Arbre);
   end commande_15_deux_parents_connus;

   procedure commande_16_identifier_ancetre_paternel(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      id : Integer;
      generation : Integer;
      compteur : Integer := 0;
   begin
      Put_Line("=> De quel individu recherchez-vous l'ancêtre paternel ?");
      Get(id);
      Put_Line("=> À quelle génération par rapport à cet individu voulez-vous rechercher son ancêtre paternel ?");
      Get(generation);
      if generation = 0 then
         Put_Line("=> L'individu n'a pas d'ancêtre paternel pour la génération 0 (cela correspond à lui-même)");
      else
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         Put_Line("=> Voici l'ancêtre paternel de l'individu" & Integer'Image(id) & ":");
         identifierAncetrePaternel(arbre, generation, compteur);
      end if;
   end commande_16_identifier_ancetre_paternel;

   procedure commande_17_identifier_ancetre_maternel(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      id : Integer;
      generation : Integer;
      compteur : Integer := 0;
   begin
      Put_Line("=> De quel individu recherchez-vous l'ancêtre maternel ?");
      Get(id);
      Put_Line("=> À quelle génération par rapport à cet individu voulez-vous rechercher son ancêtre maternel ?");
      Get(generation);
      if generation = 0 then
         Put_Line("=> L'individu n'a pas d'ancêtre maternel pour la génération 0 (cela correspond à lui-même)");
      else
         arbre := arbre_genealogique.recherche(F_Arbre, individu_Integer.creerIndividu_Id(id), false);
         Put_Line("=> Voici l'ancêtre maternel de l'individu" & Integer'Image(id) & ":");
         identifierAncetreMaternel(arbre, generation, compteur);
      end if;
   end commande_17_identifier_ancetre_maternel;

   procedure commande_18_afficher_entierement(F_Arbre : in arbre_genealogique.T_Arbre_Bin) is
   begin
      if arbre_genealogique.estVide(F_Arbre) then
         Put_Line("L'arbre est vide : rien à afficher");
      else
         Put_Line("☐☐☐☐☐☐☐☐☐☐☐☐☐☐☐");
         afficherArbreGen(F_Arbre, 0);
         New_Line;
         Put_Line("☐☐☐☐☐☐☐☐☐☐☐☐☐☐☐");
      end if;
   end commande_18_afficher_entierement;

   procedure commande_19_creer_arbre_prerempli(F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
      arbre : arbre_genealogique.T_Arbre_Bin;
      informations : individu_Integer.PT_Informations;
   begin
      if not arbre_genealogique.estVide(F_Arbre) then
         Put_Line("Un arbre avait déjà été créé. Il a été supprimé.");
      end if;
      informations := individu_Integer.creerInformations(To_Unbounded_String("Rodriguez"),
                                                         To_Unbounded_String("Diego"),
                                                         To_Unbounded_String("M"),
                                                         To_Unbounded_String("08/11/1999"),
                                                         To_Unbounded_String("n/a"),
                                                         To_Unbounded_String("11 rue André Mercadier"));
      creer(F_Arbre, individu_Integer.creerIndividu(1, informations));
      ajouterPere(F_Arbre, individu_Integer.creerIndividu_Id(10));
      ajouterMere(F_Arbre, individu_Integer.creerIndividu_Id(11));

      arbre := arbre_genealogique.getSousArbreGauche(F_Arbre);
      informations := individu_Integer.creerInformations(To_Unbounded_String("Nathalie"),
                                                         To_Unbounded_String("Dupont"),
                                                         To_Unbounded_String("F"),
                                                         To_Unbounded_String("n/a"),
                                                         To_Unbounded_String("n/a"),
                                                         To_Unbounded_String("n/a"));
      ajouterPere(arbre, individu_Integer.creerIndividu(20, informations));

      arbre := arbre_genealogique.getSousArbreGauche(arbre);
      ajouterPere(arbre, individu_Integer.creerIndividu_Id(30));
      ajouterMere(arbre, individu_Integer.creerIndividu_Id(31));

      arbre := arbre_genealogique.getSousArbreDroit(F_Arbre);
      ajouterPere(arbre, individu_Integer.creerIndividu_Id(21));
      ajouterMere(arbre, individu_Integer.creerIndividu_Id(22));

      arbre := arbre_genealogique.getSousArbreGauche(arbre);
      ajouterPere(arbre, individu_Integer.creerIndividu_Id(32));

      arbre := arbre_genealogique.getSousArbreGauche(arbre);
      ajouterMere(arbre, individu_Integer.creerIndividu_Id(40));

      arbre := arbre_genealogique.getSousArbreDroit(arbre);
      ajouterMere(arbre, individu_Integer.creerIndividu_Id(51));
      ajouterPere(arbre, individu_Integer.creerIndividu_Id(50));

      Put_Line("Arbre prérempli créé ! Voici l'arbre :");
      New_Line;
      commande_18_afficher_entierement(F_Arbre);
   end commande_19_creer_arbre_prerempli;

   procedure traitement_choix(F_Choix : in Integer; F_Arbre : in out arbre_genealogique.T_Arbre_Bin) is
   begin
      case F_Choix is
         when 1 => commande_1_creer_arbre(F_arbre);
         when 2 => commande_2_ajouter_pere(F_arbre);
         when 3 => commande_3_ajouter_mere(F_arbre);
         when 4 => commande_4_nombre_ancetres(F_arbre);
         when 5 => commande_5_identifier_ancetres(F_arbre);
         when 6 => commande_6_ensemble_ancetres(F_arbre);
         when 7 => commande_7_identifier_descendants(F_Arbre);
         when 8 => commande_8_ensemble_descendants(F_Arbre);
         when 9 => commande_9_afficher(F_Arbre);
         when 10 => commande_10_supprimer_branche(F_Arbre);
         when 11 => commande_11_modifier_individu(F_Arbre);
         when 12 => commande_12_modifier_totalement_individu(F_Arbre);
         when 13 => commande_13_aucun_parent_connu(F_Arbre);
         when 14 => commande_14_un_parent_connu(F_Arbre);
         when 15 => commande_15_deux_parents_connus(F_Arbre);
         when 16 => commande_16_identifier_ancetre_paternel(F_Arbre);
         when 17 => commande_17_identifier_ancetre_maternel(F_Arbre);
         when 18 => commande_18_afficher_entierement(F_Arbre);
         when 19 => commande_19_creer_arbre_prerempli(F_Arbre);
         when 0 => null;

         when others => Put_Line("/!\ Veuillez indiquer votre choix avec un nombre entre 0 et 19 inclus /!\");
      end case;
   end traitement_choix;

   procedure manipulation_arbre_gen(F_arbre : in out arbre_genealogique.T_Arbre_Bin) is
      choix : Integer;
      afficher_menu : Integer;
   begin
      loop
         loop
            New_Line;
            Put_Line("Voulez-vous afficher le menu ?");
            Put_Line("  OUI => Tapez 1");
            Put_Line("  NON => Tapez 2");
            New_Line;
            Get(afficher_menu);
            exit when afficher_menu = 1 or afficher_menu = 2;
         end loop;
         if afficher_menu = 1 then
            afficherMenu;
         else
            null;
         end if;
         Get(choix);
         exit when choix >= 0 and choix < 20;
      end loop;
      traitement_choix(choix, F_arbre);
      if choix /= 0 then
         manipulation_arbre_gen(F_arbre);
      else
         Put_Line("Fin du programme, Merci");
      end if;
   end;

end menu;
