with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Arbre_Bin;

procedure test_manuel_arbre_binaire is

   package Arbre_Binaire is new Arbre_Bin(T_Element => Integer, estEquivalent => "=");
   use Arbre_Binaire;


   procedure afficher( arbre : in T_Arbre_Bin)is
   begin
      if not estVide(arbre => arbre) then
         Put(Integer'Image(getElement(arbre)));
         afficher(getSousArbreGauche(arbre => arbre));
         afficher(getSousArbreDroit(arbre => arbre));
      else
         null;
      end if;
   end;

   a, b : T_Arbre_Bin;
begin
   initialiser(a);

   if estVide(a) then
      afficher(a); New_Line;
      Put(Integer'Image(taille(a))); New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("0");
   end if;New_Line;

   inserer(arbre => a, element_precedent => 0, nouvel_element => 5, inserer_a_droite => true);
   if not estVide(a) then
      afficher(a); New_Line;
      Put(Integer'Image(taille(a))); New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("5");
      Put_Line("1");
   end if;New_Line;

   inserer(arbre => a, element_precedent => 5, nouvel_element => 4, inserer_a_droite => false);
   if not estVide(a) then
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("5 4");
      Put_Line("2");
   end if;New_Line;

   inserer(arbre => a, element_precedent => 5, nouvel_element => 12, inserer_a_droite => true);
   if not estVide(a) then
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("5 4 12");
      Put_Line("3");
   end if;New_Line;

   b := recherche(arbre => a, element => 4, retourner_precedent => false);
   if not estVide(b) then
      afficher(b); New_Line;
      Put(Integer'Image(taille(b)));New_Line;
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("4");
      Put_Line("1");
      Put_Line("5 4 12");
      Put_Line("3");
   end if;New_Line;

   b := recherche(arbre => a, element => 4, retourner_precedent => true);
   if not estVide(b) then
      afficher(b); New_Line;
      Put(Integer'Image(taille(b)));New_Line;
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("5 4 12");
      Put_Line("3");
      Put_Line("5 4 12");
      Put_Line("3");
   end if;New_Line;

   b := recherche(arbre => a, element => 5, retourner_precedent => false);
   if not estVide(b) then
      afficher(b); New_Line;
      Put(Integer'Image(taille(b)));New_Line;
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("5 4 12");
      Put_Line("3");
      Put_Line("5 4 12");
      Put_Line("3");
   else
      Put_Line("Valeur non trouvée");
   end if;New_Line;

   begin
      b := recherche(arbre => a, element => 5, retourner_precedent => true);
      if not estVide(b) then
         afficher(b); New_Line;
         Put(Integer'Image(taille(b)));New_Line;
         afficher(a); New_Line;
         Put(Integer'Image(taille(a)));New_Line;
      end if;
   exception
      when element_absent => Put_Line("Ok");
   end;New_Line;

   b := recherche(arbre => a, element => 8, retourner_precedent => false);
   if estVide(b) then
      Put_Line("Ok");
   end if;New_Line;


   modifier(arbre => a, src_element => 4, tar_element => 8);
   if not estVide(a) then
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
      Put_line("Resultat Attendu : ");
      Put_Line("5 8 12");
      Put_Line("3");
   end if;New_Line;

   inserer(arbre => a, element_precedent => 8, nouvel_element => 88,inserer_a_droite => true);
   afficher(a); New_Line;
   Put_Line(Integer'Image(taille(a)));
   Put_line("Resultat Attendu : ");
   Put_Line("5 8 88 12");
   Put_Line("4");

   New_Line;

   begin
      inserer(arbre => a, element_precedent => 8, nouvel_element => 88,inserer_a_droite => false);
      Put("Erreur");
   exception
      when element_existant => Put_Line("Ok");
   end;New_Line;

   begin
      inserer(arbre => a, element_precedent => 7, nouvel_element => 10,inserer_a_droite => false);
      Put("Erreur");
   exception
      when element_absent => Put_Line("Ok");
   end;New_Line;

   supprimer(arbre => a, element => 8);
   afficher(a); New_Line;
   Put_Line(Integer'Image(taille(a)));
   Put_line("Resultat Attendu : ");
   Put_Line("5 12");
   Put_Line("2");
   New_Line;

   begin
      supprimer(arbre => a, element => 10);
      Put("Erreur");
   exception
      when element_absent => Put_Line("Ok");
   end;New_Line;

   supprimer(arbre => a, element => 5);
   if estVide(a) then
      Put_Line("Arbre correctement supprimé");
   else
      afficher(a); New_Line;
      Put(Integer'Image(taille(a)));New_Line;
   end if;New_Line;

end test_manuel_arbre_binaire;
