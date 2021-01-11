package body Individu is 
 
   function creerIndividu(F_Id : in T_Identifiant) return T_Individu is
      individu : T_Individu;
   begin
      individu.id := id;
      individu.informations := null;
      return individu;
   end creerIndividu;

    procedure afficherIndividuId(F_Individu : in T_Individu) is
    begin
        afficherId(F_Individu);
    end afficherIndividuId;

end Individu;