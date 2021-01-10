with Arbre_Bin:
with infos;


package individu is

    type T_Noeud_genealog is private;

    type T_Individu is private;

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


private
    type T_Noeud_genealog is record
        id : Integer;
        informations : T_infos;
    end record;

    type T_Individu is record
        nom : String(1..CMAX);
        prenom : String(1..CMAX);
        sexe : Character;
        date_naissance : String(1..CMAX);
        date_deces : String(1..CMAX);
    end record;

end individu;