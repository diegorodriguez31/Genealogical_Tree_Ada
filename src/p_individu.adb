

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
      --  Skip_Line;
      Put("Entrez le prenom : ");
      prenom := To_Unbounded_String(Get_Line);
      New_Line;

      informations := creerInformations(nom => nom, prenom => prenom);
      return informations;
   end creerInformations;

   --  Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerInformations(nom : in Unbounded_String ; prenom : in Unbounded_String  ) return T_Informations is
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

   -- Affiche les informations et l'identifiant d'un individu
   procedure afficherIndividu(individu : in T_Individu) is
   begin
      afficherIdentifiant(individu.identifiant);
      Put(" ; ");
      afficherInformations(informations => individu.informations);
   end afficherIndividu;

   -- Affiche les informations d'un individu
   procedure afficherInformations(informations : in T_Informations) is
   begin
      if not (informations = null) then
         Put("Nom : " & To_String(informations.all.nom));
         Put(", ");
         Put("Prenom : " & To_String(informations.all.prenom));
      else
         null;
      end if;
   end afficherInformations;

   -- Retourne le nom de l'individu
   function getNom(informations : in T_Informations) return Unbounded_String is
   begin
      if informations = null then
         raise null_informations;
      else
         return informations.all.nom;
      end if;
   end getNom;


   -- Retourne le nom de l'individu
   function getPrenom(informations : in T_Informations) return Unbounded_String is
   begin
      if informations = null then
         raise null_informations;
      else
         return informations.all.prenom;
      end if;
   end getPrenom;

end P_Individu;
