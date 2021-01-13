with Ada.Text_IO; ada.Text_IO;

generic
    type T_Identifiant is private;

package individu is

    type T_Individu is private;

    type T_Informations is private;

    CMAX : constant Integer := 30; -- Taille maximum de chaîne de caractère

    -- Getters / Setters
    procedure set_nom(individu : in out T_Individu ; nom : in String);
    function get_nom(individu : in T_Individu) return String;

    procedure set_prenom(individu : in out T_Individu ; prenom : in String);
    function get_prenom(individu : in T_Individu) return String;

    procedure set_sexe(individu : in out T_Individu ; sexe : in Character);
    function get_sexe(individu : in T_Individu) return Character;

    procedure set_date_naissance(individu : in out T_Individu ; date_naissance : in String);
    function get_date_naissance(individu : in T_Individu) return String;

    procedure set_date_deces(individu : in out T_Individu ; date_naissance : in String);
    function get_date_deces(individu : in T_Individu) return String;

    function creerIndividu(id : in T_Identifiant) return T_Individu;
    
    generic
        with procedure afficherId(F_Individu : in T_Individu);
    procedure afficherIndividuId(F_Individu : in T_Individu);


private
    -- Je choisis de pointer sur l'enregistrement des informations pour pouvoir mettre le pointeur à null s'il n'y a pas d'information
    type PT_informations is access T_Informations;

    type T_Informations is record
        Nom : String(1..CMAX);
        Prenom : String(1..CMAX);
        Sexe : Character;
        Date_naissance : String(1..CMAX);
        Date_deces : String(1..CMAX);
    end record;

    type T_Individu is record
        Id : T_Identifiant;
        Informations : PT_informations;
    end record;

end individu;