

package body P_Individu is

   --  Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerInformations return T_Informations is
      informations : T_Informations;
      nom : Unbounded_String;
      prenom : Unbounded_String;
   begin

      New_Line;
      Skip_Line;
      Put("Entrez le nom : ");
      nom := To_Unbounded_String(Get_Line);

      New_Line;
      Skip_Line;
      Put("Entrez le prenom : ");
      prenom := To_Unbounded_String(Get_Line);

      New_Line;

      informations := new T_Infos;
      informations.all.nom := nom;
      informations.all.prenom := prenom;
      return informations;
   end creerInformations;

   --  Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerIndividu(identifiant : in T_Identifiant ; informations : in T_Informations) return T_Individu is
      individu : T_Individu;
   begin
      if estNullIdentifiant(identifiant) then
         raise null_identifiant;
      else
         individu.identifiant := identifiant;
         individu.informations := informations;
         return individu;
      end if;
   end creerIndividu;

   --  Renvoie un individu avec uniquement un identifiant  qui lui correspond
   function creerIndividu(identifiant : in T_Identifiant) return T_Individu is
      individu : T_Individu;
   begin
      if estNullIdentifiant(identifiant) then
         raise null_identifiant;
      else
         individu.identifiant := identifiant;
         return individu;
      end if;
   end creerIndividu;

   -- Vérifie si deux individus sont égaux
   function estEquivalentIndividu(individu_1 : in T_Individu ; individu_2 : in T_Individu) return Boolean is
   begin
      return estEquivalentIdentifiant(individu_1.identifiant, individu_2.identifiant);
   end estEquivalentIndividu;

   -- Affiche les informations d'un individu
   procedure afficherIndividu(individu : in T_Individu) is
   begin
      afficherIdentifiant(individu.identifiant);
      if not (individu.informations = null) then
         Put(" : ");
         Put(individu.informations.all.nom);
         Put(", ");
         Put(individu.informations.all.prenom);
      else
         null;
      end if;
   end afficherIndividu;

end P_Individu;
