-- Retour arrière du durcissement RLS du 20 août 2026
--
-- ATTENTION : rejouer ce script rétablit l'exposition des données clients.
-- Il n'existe que pour restaurer l'état exact d'avant l'intervention en cas
-- de régression fonctionnelle imprévue du panneau admin.
--
-- Définitions relevées sur la base avant retrait, via pg_policies.

CREATE POLICY auth_all_bookings ON public.bookings
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_orders ON public.orders
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_products ON public.products
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_quotes ON public.quotes
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_requests ON public.requests
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_settings ON public.site_settings
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_testimonials ON public.testimonials
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY auth_all_vehicles ON public.vehicles
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY admin_read_profiles ON public.profiles
  FOR SELECT TO authenticated USING (true);
