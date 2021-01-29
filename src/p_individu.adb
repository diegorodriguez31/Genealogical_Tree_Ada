

package body P_Individu is

   -- R0: Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerInformations return T_Informations is
      informations : T_Informations;
      nom : Unbounded_String;
      prenom : Unbounded_String;
   begin
      -- R1 : Saisir le nom
      New_Line;
      Skip_Line;
      Put("Entrez le nom : ");
      nom := To_Unbounded_String(Get_Line);
      -- R1 : Saisir le prenom
      Put("Entrez le prenom : ");
      prenom := To_Unbounded_String(Get_Line);
      New_Line;
      -- R1 : Creer l'enregistrement à l'aide des informations saisies
      informations := creerInformations(nom => nom, prenom => prenom);
      -- R1 : retourner l'enregistrement
      return informations;
   end creerInformations;

   -- R0: Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerInformations(nom : in Unbounded_String ; prenom : in Unbounded_String  ) return T_Informations is
      informations : T_Informations;
   begin
      --R1 : Ajouter les infromations à l'enregistrement
      informations := new T_Infos;
      informations.all.nom := nom;
      informations.all.prenom := prenom;
      -- R1 : retourner l'enregistrement
      return informations;
   end creerInformations;

   -- R0: Renvoie un individu avec uniquement un identifiant et les informations qui lui correspondent
   function creerIndividu(identifiant : in T_Identifiant ; informations : in T_Informations) return T_Individu is
      individu : T_Individu;
   begin
      -- R1 : Si l'identifiant rensigné est null, lever une exception
      if estNullIdentifiant(identifiant) then
         raise null_identifiant;
      else
         --R1 : Sinon ajouter l'identifiant et les informations à l'enregistrement
         individu.identifiant := identifiant;
         individu.informations := informations;
         --R1 : Retourner l'enregistrement
         return individu;
      end if;
   end creerIndividu;

   -- R0: Renvoie un individu avec uniquement un identifiant  qui lui correspond
   function creerIndividu(identifiant : in T_Identifiant) return T_Individu is
      individu : T_Individu;
   begin
      -- R1 : Si l'identifiant rensigné est null, lever une exception
      if estNullIdentifiant(identifiant) then
         raise null_identifiant;
      else
         --R1 : Sinon ajouter l'identifiant à l'enregistrement
         individu.identifiant := identifiant;
         --R1 : Retourner l'enregistrement
         return individu;
      end if;
   end creerIndividu;

   -- R0: Vérifie si deux individus sont égaux
   function estEquivalentIndividu(individu_1 : in T_Individu ; individu_2 : in T_Individu) return Boolean is
   begin
      return estEquivalentIdentifiant(individu_1.identifiant, individu_2.identifiant);
   end estEquivalentIndividu;

   -- Affiche les informations et l'identifiant d'un individu
   procedure afficherIndividu(individu : in T_Individu) is
   begin
      afficherIdentifiant(individu.identifiant);
      Put(" ( ");
      afficherInformations(informations => individu.informations);
      Put(" ) ");
   end afficherIndividu;

   -- R0: Affiche les informations d'un individu
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

   -- R0: Retourne le nom de l'individu
   function getNom(informations : in T_Informations) return Unbounded_String is
   begin
      if informations = null then
         raise null_informations;
      else
         return informations.all.nom;
      end if;
   end getNom;

   -- R0: Retourne le nom de l'individu
   function getPrenom(informations : in T_Informations) return Unbounded_String is
   begin
      if informations = null then
         raise null_informations;
      else
         return informations.all.prenom;
      end if;
   end getPrenom;

   -- R0: Retourne l'identifiant de l'individu
   function getIdentifiant(individu : in T_Individu) return T_Identifiant is
   begin
         return individu.identifiant;
   end getIdentifiant;

   -- R0: Retourne les informations de l'individu
   function getInformations(individu : in T_Individu) return T_Informations is
   begin
         return individu.informations;
   end getInformations;


end P_Individu;
