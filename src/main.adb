with Arbre_Bin;
with arbre_genealog;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

    package arbre_geneal is new Arbre_Genealog(T_Identifiant => Integer);
    use arbre_geneal;

    arbre : arbre_genealogique.T_Arbre_Bin;
    

    --Put(Integer'Image(x));

arbre : T_arbre_geneal;
test_pere : T_arbre_geneal;
begin

    arbre := arbre_geneal.creer(creerIndividu(1));

    Put_line("---------------------Affichage de l'arbre--------------------");

    arbre := arbre_geneal.creer(indiv.creerIndividu(1));
    ajouterPere(arbre, ...);
    ajouterMere(arbre, ...);
    test_pere := identifierAncetres(10,1);
    afficher(arbre);
    Put_line("----------------Fin de l'affichage de l'arbre----------------");
   
end Main;
