with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

generic
   -- le type de l'identifiant permettant de différencier deux individus
   type T_Identifiant is private;
   --Une fonction permettant de vérifier l'égalité entre deux identifiants
   with function estEquivalentIdentifiant( identifiant_1 : in T_Identifiant ; identifiant_2 : in T_Identifiant) return Boolean;
   --Une fonction permettant de vérifier si l'identifiant est null
   with function estNullIdentifiant( identifiant : in T_Identifiant) return Boolean;
   -- Une procedure permettant d'afficher l'identifiant d'un individu
   with procedure afficherIdentifiant(identifiant : in T_Identifiant);
package P_Individu is

   type T_Informations is private;
   type T_Individu is private;

   null_identifiant : exception;
   null_individu : exception;

   -- Sémantique : Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   -- Paramètres :
   --   nom : IN Unbounded_String, nom de l'individu
   --   prenom : IN Unbounded_String, nom de l'individu
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : T_Informations, regroupant les informations données en paramètre
   -- Exceptions : Néant
   function creerInformations(nom : in Unbounded_String ; prenom : in Unbounded_String) return T_Informations;

   -- Sémantique : Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   -- Paramètres :
   --   identifiant : IN T_Identifiant, identifiant de l'individu a créer
   --   informations : T_Informations, enregistrement d'informations de l'individu
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est créé avec l'identifiant et les informations donnés en paramètre
   -- Retourne : T_Individu, l'individu
   -- Exceptions : Néant
   function creerIndividu(identifiant : in T_Identifiant ; informations : in T_Informations) return T_Individu;

   -- Sémantique : Vérifie si deux individus sont égaux
   -- Paramètres :
   --   individu_1 : IN T_Individu, le premier individu
   --   identifiant_2 : IN T_Individu, le deuxième individu
   -- Pré-conditions : Néant
   -- Post-conditions : Néant
   -- Retourne : Boolean, vrai si les individus ont des identifiants équivalents, faux sinon
   -- Exceptions : Néant
   function estEquivalentIndividu(individu_1 : in T_Individu ; individu_2 : in T_Individu) return Boolean;

   -- Sémantique : Affiche les informations d'un individu
   -- Paramètres :
   --   individu : IN T_Individu, l'individu à afficher
   -- Pré-conditions : Néant
   -- Post-conditions : L'individu est affiché
   -- Exceptions : Néant
   procedure afficherIndividu(individu : in T_Individu);

private

   type T_Infos is record
      nom : Unbounded_String;
      prenom : Unbounded_String;
   end record;

   type T_Informations is access T_Infos;

   type T_Individu is record
      identifiant : T_Identifiant;
      informations : T_Informations;
   end record;


end P_Individu;
