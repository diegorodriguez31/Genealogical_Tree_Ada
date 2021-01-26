
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
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
      return false; -- Un entier ne peut être null
   end nullIdendifiant;


   -- Instanciation d'un individu avec l'identifiant de type Integer
   package individu_int is new P_Individu(T_Identifiant => Integer, estEquivalentIdentifiant => "=", afficherIdentifiant => affichIdentifiant, estNullIdentifiant => nullIdendifiant );
   use individu_int;

   --  ind_1, ind_2 : T_Individu;
   inf_1, inf_2 : T_Informations;
   nom_1, prenom_1, nom_2, prenom_2 : Unbounded_String;
begin

   -- Du fait de sa nature, la fonction // function creerInformations return T_Informations; \\ ne sera pas testée dans ce programme de test
   -- Cependant, l'utilisation de la méthode Get est vérifiée a chaque execution du programme

   --Test de function creerInformations(nom : in Unbounded_String ; prenom : in Unbounded_String) return T_Informations;
   nom_1 := To_Unbounded_String("DUPOND");
   prenom_1 := To_Unbounded_String("Charles");
   inf_1 := creerInformations(nom => nom_1, prenom => prenom_1);
   afficherInformations(informations => inf_1);
   Put_Line("Résultat Attendu  : Nom : DUPOND, Prenom : Charles ");
   pragma Assert(To_Unbounded_String("DUPOND") = getNom(informations => inf_1));


   -- Sémantique : Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   -- Paramètres :
   --   identifiant : IN T_Identifiant, identifiant de l'individu a créer
   --   informations : T_Informations, enregistrement d'informations de l'individu
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est créé avec l'identifiant et les informations donnés en paramètre
   -- Retourne : T_Individu, l'individu
   -- Exceptions :
   --       null_identifiant, si lidentifiant donné est null
   --  function creerIndividu(identifiant : in T_Identifiant ; informations : in T_Informations) return T_Individu;

   -- Sémantique : Renvoie un individu avec uniquement un identifiant  qui lui correspond
   -- Paramètres :
   --   identifiant : IN T_Identifiant, identifiant de l'individu a créer
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est créé avec l'identifiant et les informations donnés en paramètre
   -- Retourne : T_Individu, l'individu
   -- Exceptions :
   --       null_identifiant, si lidentifiant donné est null
   --  function creerIndividu(identifiant : in T_Identifiant) return T_Individu;

   -- Sémantique : Vérifie si deux individus sont égaux
   -- Paramètres :
   --   individu_1 : IN T_Individu, le premier individu
   --   identifiant_2 : IN T_Individu, le deuxième individu
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Boolean, vrai si les individus ont des identifiants équivalents, faux sinon
   -- Exceptions : Néant
   --  function estEquivalentIndividu(individu_1 : in T_Individu ; individu_2 : in T_Individu) return Boolean;

   -- Sémantique : Affiche les informations d'un individu
   -- Paramètres :
   --   individu : IN T_Individu, l'individu à afficher
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est affiché
   -- Exceptions : Néant
   --  procedure afficherIndividu(individu : in T_Individu);

end test_p_individu;
