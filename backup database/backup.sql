PGDMP                       |            postgres    16.3    16.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE     j   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3603            �            1259    16736    ads    TABLE     �   CREATE TABLE public.ads (
    ad_id bigint,
    title text,
    product_id bigint,
    user_id bigint,
    allow_bid boolean
);
    DROP TABLE public.ads;
       public         heap    postgres    false                      0    16736    ads 
   TABLE DATA           K   COPY public.ads (ad_id, title, product_id, user_id, allow_bid) FROM stdin;
    public          postgres    false    219   �          S  x�=�An�0��+��¤��yB��K/�����Ggem�E0b�#1������-#��w�����W���9y`���;�}�wVO���#��ڱ�G�'�s�8#��
Oާp�������k�R�T��feӻ� ���2@N��"�t〒��y�����JW�
��-� �є �ө�ys�^�Y �Q�@�e	���*[ u_@Y�)As� �n�� ���� (*��y7�-����07]�B� ���� ��"� �޺ 2T�@$�m �ҰZ ۽�04��, �y�� ��;^���� @�>, �Y� @R� �{�  �� �����Z�^\�X     