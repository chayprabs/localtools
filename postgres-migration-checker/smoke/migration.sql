-- Representative existing application table migration; original sample, CC0.
SET lock_timeout = '5s';
SET statement_timeout = '30min';
ALTER TABLE public.users ADD COLUMN display_name text;
CREATE INDEX users_display_name_idx ON public.users(display_name);
ALTER TABLE public.users ADD CONSTRAINT display_name_present CHECK (display_name IS NOT NULL);
