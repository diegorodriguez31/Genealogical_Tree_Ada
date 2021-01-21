

package body P_Individu is

   --  Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerInformations(nom : in Unbounded_String ; prenom : in Unbounded_String) return T_Informations is
      informations : T_Informations;
   begin
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
