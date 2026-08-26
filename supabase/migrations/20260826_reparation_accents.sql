-- Réparation des accents perdus — 26 août 2026
--
-- Trois libellés sont arrivés en base avec des caractères de remplacement à
-- la place de leurs accents : les octets d'origine ont été perdus au moment
-- de l'insertion, ce n'est pas un simple problème d'affichage.
--
-- Tant que le site public lisait les constantes du fichier, personne ne le
-- voyait. Maintenant qu'il lit la table, « Avensis ? T?te de Cochon ? »
-- s'afficherait tel quel sur webshop237.com. Les valeurs correctes sont
-- reprises des constantes VEHICLES, PRODUCTS et TESTIMONIALS d'index.html.
--
-- Retour arrière : aucun. Remettre des libellés illisibles n'aurait pas de sens.

UPDATE public.vehicles     SET name = 'Avensis « Tête de Cochon »' WHERE id = 'avensis';
UPDATE public.products     SET name = 'Écouteurs Sans Fil'         WHERE id = '4';
UPDATE public.testimonials SET name = 'Aïcha N.'                   WHERE id = 1;

-- Deux autres libellés avaient simplement perdu leurs accents, sans laisser de
-- caractère de remplacement : invisibles au premier passage, repérés en
-- comparant chaque nom de la base à celui du fichier.
UPDATE public.products SET name = 'Mocassins Édition' WHERE id = '5';
UPDATE public.products SET name = 'Pochette Soirée'   WHERE id = '6';
