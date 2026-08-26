-- Retour arrière de la lecture publique des coordonnées — 26 août 2026
--
-- ATTENTION : retirer cette policy fait retomber le site sur les coordonnées
-- écrites en dur dans index.html. Rien ne casse à l'écran, mais le panneau
-- admin redevient sans effet sur le téléphone, l'adresse et les liens sociaux.

DROP POLICY IF EXISTS site_settings_read_public ON public.site_settings;
