with arbre_genealog; use arbre_genealog;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

    arbre : arbre_genealogique.T_Arbre_Bin;
    package arbre_geneal is new Arbre_Genealog(T_Identifiant => Integer);
    use arbre_geneal;

    arbre : arbre_genealogique.T_Arbre_Bin;
    

    --Put(Integer'Image(x));

arbre : T_arbre_geneal;
test_pere : T_arbre_geneal;
begin

   arbre := creerArbre(indiv.creerIndividu(1));
   ajouterPere(arbre, indiv.creerIndividu(2));
   ajouterMere(arbre, indiv.creerIndividu(3));
   ajouterMere(arbre_genealogique.getSousArbreDroit(arbre), indiv.creerIndividu(22));
   ajouterPere(arbre_genealogique.getSousArbreGauche(arbre), indiv.creerIndividu(33));
   ajouterMere(arbre_genealogique.getSousArbreGauche(arbre), indiv.creerIndividu(34));
   ajouterPere(arbre_genealogique.getSousArbreGauche(arbre_genealogique.getSousArbreGauche(arbre)), indiv.creerIndividu(333));
   afficher(arbre, 0);
   
    arbre := arbre_geneal.creer(indiv.creerIndividu(1));
    ajouterPere(arbre, ...);
    ajouterMere(arbre, ...);
    test_pere := identifierAncetres(10,1);

    Put_line("---------------------Affichage de l'arbre--------------------");
    afficher(arbre);
    Put_line("----------------Fin de l'affichage de l'arbre----------------");


    

   
end Main;
