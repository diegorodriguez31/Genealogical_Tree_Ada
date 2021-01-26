
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with P_Individu;

procedure test_p_individu is
   --Indique comment afficher l'identifiant d'un individu
   procedure affichIdentifiant(identifiant : in Integer) is
   begin
      Put(Integer'Image(identifiant));
   end affichIdentifiant;

   function nullIdendifiant(identifiant : in Integer) return Boolean is
   begin
      return identifiant < 0; -- Un entier ne peut être null, pour cet exemple on considérera donc les valeurs négatives comme null
   end nullIdendifiant;


   -- Instanciation d'un individu avec l'identifiant de type Integer
   package individu_int is new P_Individu(T_Identifiant => Integer, estEquivalentIdentifiant => "=", afficherIdentifiant => affichIdentifiant, estNullIdentifiant => nullIdendifiant );
   use individu_int;

   ind_1, ind_2 : T_Individu;
   inf_1, inf_2 : T_Informations;
   nom_1, prenom_1, nom_2, prenom_2 : Unbounded_String;
begin
   Put_Line("Debut du test de p_individu");
   -- Du fait de sa nature, la fonction // function creerInformations return T_Informations; \\ ne sera pas testée dans ce programme de test
   -- Cependant, l'utilisation de la méthode Get est vérifiée a chaque execution du programme

   --Test de function creerInformations(nom : in Unbounded_String ; prenom : in Unbounded_String) return T_Informations;
   nom_1 := To_Unbounded_String("DUPOND");
   prenom_1 := To_Unbounded_String("Charles");
   inf_1 := creerInformations(nom => nom_1, prenom => prenom_1);
   pragma Assert(To_Unbounded_String("DUPOND") = getNom(informations => inf_1));
   pragma Assert(To_Unbounded_String("Charles") = getPrenom(informations => inf_1));

   nom_2 := To_Unbounded_String("");
   prenom_2 := To_Unbounded_String("");
   inf_2 := creerInformations(nom => nom_2, prenom => prenom_2);
   pragma Assert(To_Unbounded_String("") = getNom(informations => inf_2));
   pragma Assert(To_Unbounded_String("") = getPrenom(informations => inf_2));


   -- Test de function creerIndividu(identifiant : in T_Identifiant ; informations : in T_Informations) return T_Individu;
   ind_1 := creerIndividu(identifiant => 1, informations => inf_1);
   pragma Assert(getIdentifiant(individu => ind_1) = 1);
   pragma Assert(getInformations(individu => ind_1) = inf_1);

   begin
      ind_1 := creerIndividu(identifiant => -1, informations => inf_2);
      pragma Assert(false);
   exception
      when null_identifiant =>
         pragma Assert(true);
   end;

   ind_2 := creerIndividu(identifiant => 1, informations => inf_2);
   pragma Assert(getIdentifiant(individu => ind_2) = 1);
   pragma Assert(getInformations(individu => ind_2) = inf_2);



   -- Test de function creerIndividu(identifiant : in T_Identifiant) return T_Individu;
   ind_1 := creerIndividu(identifiant => 1);
   pragma Assert(getIdentifiant(individu => ind_1) = 1);

   begin
      ind_1 := creerIndividu(identifiant => -1);
      pragma Assert(false);
   exception
      when null_identifiant =>
         pragma Assert(true);
   end;


   -- Test de function estEquivalentIndividu(individu_1 : in T_Individu ; individu_2 : in T_Individu) return Boolean;
   ind_1 := creerIndividu(identifiant => 1);
   ind_2 := creerIndividu(identifiant => 1);
   pragma Assert(estEquivalentIndividu(individu_1 => ind_1, individu_2 => ind_1));
   pragma Assert(estEquivalentIndividu(individu_1 => ind_1, individu_2 => ind_2));
   ind_1 := creerIndividu(identifiant => 1, informations => inf_1);
   pragma Assert(estEquivalentIndividu(individu_1 => ind_1, individu_2 => ind_2));
   ind_2 := creerIndividu(identifiant => 1, informations => inf_2);
   pragma Assert(estEquivalentIndividu(individu_1 => ind_1, individu_2 => ind_2));
   ind_1 := creerIndividu(identifiant => 0);
   pragma Assert(not estEquivalentIndividu(individu_1 => ind_1, individu_2 => ind_2));
   ind_2 := creerIndividu(identifiant => 1);
   pragma Assert(not estEquivalentIndividu(individu_1 => ind_1, individu_2 => ind_2));

   -- Test de procedure afficherIndividu(individu : in T_Individu);
   -- Par la meme occasion, test de afficherInformations(informations : in T_Informations)
   -- qui est utilisée dans afficherIndividu.
   ind_1 := creerIndividu(identifiant => 3, informations => inf_1);
   afficherIndividu(individu => ind_1);
   New_Line;
   Put_Line("Resultat attendu : 3 ( Nom : DUPOND, Prenom : Charles )");
   New_Line;

   ind_1 := creerIndividu(identifiant => 4, informations => inf_2);
   afficherIndividu(individu => ind_1);
   New_Line;
   Put_Line("Resultat attendu : 3 ( Nom : , Prenom : )");
   New_Line;

   ind_1 := creerIndividu(identifiant => 5);
   afficherIndividu(individu => ind_1);
   New_Line;
   Put_Line("Resultat attendu : 5 (  )");
   New_Line;

   --  Test de function getNom(informations : in T_Informations) return Unbounded_String;
   ind_1 := creerIndividu(identifiant => 5);
   begin
      nom_2 := getNom(getInformations(individu => ind_1));
      pragma Assert(false);
   exception
      when NULL_INFORMATIONS =>
         pragma Assert(true);
   end;

   ind_1 := creerIndividu(identifiant => 5, informations => inf_1);
   nom_2 := getNom(getInformations(individu => ind_1));
   pragma Assert(nom_1 = nom_2);

   -- Test de function getPrenom(informations : in T_Informations) return Unbounded_String;
   ind_1 := creerIndividu(identifiant => 5);
   begin
      prenom_2 := getPrenom(getInformations(individu => ind_1));
      pragma Assert(false);
   exception
      when NULL_INFORMATIONS =>
         pragma Assert(true);
   end;

   ind_1 := creerIndividu(identifiant => 5, informations => inf_1);
   prenom_2 := getPrenom(getInformations(individu => ind_1));
   pragma Assert(prenom_1 = prenom_2);

   -- Test de function getIdentifiant(individu : in T_Individu) return T_Identifiant;
   -- Deja testé dans creerIndividu
   -- Test de function getInformations(individu : in T_Individu) return T_Informations;
   -- Deja testé dans creerIndividu


   Put_Line("Fin du test de p_individu");
end test_p_individu;
