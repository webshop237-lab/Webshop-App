-- Retour arrière de la table des forfaits — 26 août 2026
--
-- ATTENTION : supprimer la table efface les forfaits créés depuis le panneau
-- admin. Le site retombe sur les trois forfaits écrits dans les traductions
-- de index.html, donc la grille reste affichée, mais toute modification faite
-- depuis l'admin est perdue.

DROP POLICY IF EXISTS packages_read_public ON public.packages;
DROP POLICY IF EXISTS packages_write_admin ON public.packages;
DROP TABLE IF EXISTS public.packages;
