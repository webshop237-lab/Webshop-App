-- Lecture publique des coordonnées du site — 26 août 2026
--
-- Contexte : le pied de page et la section Contact affichaient le téléphone,
-- l'adresse et les liens sociaux écrits en dur dans index.html. Les modifier
-- depuis le panneau admin ne changeait rien pour le visiteur, faute de pouvoir
-- lire la table avec la clé anon.
--
-- La lecture publique est volontairement limitée à une liste de clés, au lieu
-- d'ouvrir la table entière. Si un secret atterrit un jour dans site_settings,
-- par erreur ou par facilité, il ne sera pas servi au monde entier : il faudra
-- l'ajouter explicitement à cette liste pour qu'il sorte. L'écriture, elle,
-- reste réservée à is_admin() par la policy site_settings_all_admin.
--
-- Retour arrière : 20260826_site_settings_lecture_publique_rollback.sql

CREATE POLICY site_settings_read_public ON public.site_settings
  FOR SELECT TO anon, authenticated
  USING (key IN ('phone', 'email', 'address', 'facebook', 'instagram', 'tiktok', 'whatsapp'));
