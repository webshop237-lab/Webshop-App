-- Durcissement RLS — 20 août 2026
--
-- Contexte : huit tables portaient une policy FOR ALL TO authenticated
-- USING (true) WITH CHECK (true). Les policies RLS étant permissives et
-- combinées par un OU logique, ces règles annulaient les restrictions
-- is_admin() posées à côté. Tout compte créé sur le site disposait donc
-- d'un accès complet en lecture, écriture et suppression sur les données
-- clients.
--
-- S'y ajoutait admin_read_profiles, dont le nom annonce un contrôle admin
-- mais dont la règle est un simple USING (true).
--
-- Retrait sans effet de bord : bookings, orders et quotes n'ont aucune
-- colonne reliant une ligne à un compte utilisateur, aucune fonctionnalité
-- côté membre ne peut donc en dépendre.
--
-- Retour arrière : 20260820_rls_durcissement_rollback.sql

DROP POLICY IF EXISTS auth_all_bookings     ON public.bookings;
DROP POLICY IF EXISTS auth_all_orders       ON public.orders;
DROP POLICY IF EXISTS auth_all_products     ON public.products;
DROP POLICY IF EXISTS auth_all_quotes       ON public.quotes;
DROP POLICY IF EXISTS auth_all_requests     ON public.requests;
DROP POLICY IF EXISTS auth_all_settings     ON public.site_settings;
DROP POLICY IF EXISTS auth_all_testimonials ON public.testimonials;
DROP POLICY IF EXISTS auth_all_vehicles     ON public.vehicles;
DROP POLICY IF EXISTS admin_read_profiles   ON public.profiles;
