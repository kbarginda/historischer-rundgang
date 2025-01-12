PGDMP     	                    x           Kayla    12.3    12.0 =    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16385    Kayla    DATABASE     y   CREATE DATABASE "Kayla" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE "Kayla";
                Kayla    false            �           0    0    Kayla    DATABASE PROPERTIES     I   ALTER DATABASE "Kayla" SET search_path TO '$user', 'public', 'topology';
                     Kayla    false                        2615    17388    topology    SCHEMA        CREATE SCHEMA topology;
    DROP SCHEMA topology;
                postgres    false            �           0    0    SCHEMA topology    COMMENT     9   COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';
                   postgres    false    7                        3079    16386    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2                        3079    17389    postgis_topology 	   EXTENSION     F   CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;
 !   DROP EXTENSION postgis_topology;
                   false    2    7            �           0    0    EXTENSION postgis_topology    COMMENT     Y   COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';
                        false    3            �           1255    17660    bytea_import(text)    FUNCTION       CREATE FUNCTION public.bytea_import(p_path text, OUT p_result bytea) RETURNS bytea
    LANGUAGE plpgsql
    AS $$
    declare
      l_oid oid;
    begin
      select lo_import(p_path) into l_oid;
      select lo_get(l_oid) INTO p_result;
      perform lo_unlink(l_oid);
    end;$$;
 D   DROP FUNCTION public.bytea_import(p_path text, OUT p_result bytea);
       public          postgres    false            �            1259    17569 
   custom_poi    TABLE     E  CREATE TABLE public.custom_poi (
    id integer NOT NULL,
    poi_name character varying(100),
    added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    punkt_geom public.geometry(Point,4326) DEFAULT NULL::public.geometry,
    added_by character varying(100),
    stadtteil character(1),
    station_nr integer
);
    DROP TABLE public.custom_poi;
       public         heap    postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2            �            1259    17567    custom_poi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.custom_poi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.custom_poi_id_seq;
       public          postgres    false    219            �           0    0    custom_poi_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.custom_poi_id_seq OWNED BY public.custom_poi.id;
          public          postgres    false    218            �            1259    17555    custom_route    TABLE     d  CREATE TABLE public.custom_route (
    id integer NOT NULL,
    route_name character varying(100),
    added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    poly_geom public.geometry(Polygon,4326) DEFAULT NULL::public.geometry,
    line_geom public.geometry(LineString,4326) DEFAULT NULL::public.geometry,
    added_by character varying(100)
);
     DROP TABLE public.custom_route;
       public         heap    postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2            �            1259    17553    custom_route_id_seq    SEQUENCE     �   CREATE SEQUENCE public.custom_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.custom_route_id_seq;
       public          postgres    false    217            �           0    0    custom_route_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.custom_route_id_seq OWNED BY public.custom_route.id;
          public          postgres    false    216            �            1259    17609    pois    TABLE     M  CREATE TABLE public.pois (
    id integer NOT NULL,
    poi_name character varying(100),
    plakat_nr integer,
    stadtteil character varying(100),
    rundgang_name character varying(100),
    added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    punkt_geom public.geometry(Point,4326) DEFAULT NULL::public.geometry
);
    DROP TABLE public.pois;
       public         heap    postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2            �            1259    17607    pois_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pois_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.pois_id_seq;
       public          postgres    false    223            �           0    0    pois_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.pois_id_seq OWNED BY public.pois.id;
          public          postgres    false    222            �            1259    17582    rundgang    TABLE     ;  CREATE TABLE public.rundgang (
    id integer NOT NULL,
    rundgang_name character varying(100),
    stadtteil character varying(100),
    added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    poly_geom public.geometry(Polygon,4326) DEFAULT NULL::public.geometry,
    added_by character varying(100)
);
    DROP TABLE public.rundgang;
       public         heap    postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2            �            1259    17580    rundgang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rundgang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.rundgang_id_seq;
       public          postgres    false    221            �           0    0    rundgang_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.rundgang_id_seq OWNED BY public.rundgang.id;
          public          postgres    false    220            �            1259    17633    stadtrad_with_geom    TABLE     �   CREATE TABLE public.stadtrad_with_geom (
    station integer NOT NULL,
    name1 character varying,
    name2 character varying,
    stpl integer,
    geom public.geometry(Point,4326)
);
 &   DROP TABLE public.stadtrad_with_geom;
       public         heap    postgres    false    2    2    2    2    2    2    2    2            �            1259    17676    strecken    TABLE     7  CREATE TABLE public.strecken (
    id integer NOT NULL,
    strecken_name character varying(100),
    stadtteil character varying(100),
    added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    add_by character varying(100),
    geom public.geometry(LineString,4326) DEFAULT NULL::public.geometry
);
    DROP TABLE public.strecken;
       public         heap    postgres    false    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2    2            �            1259    17674    strecken_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strecken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.strecken_id_seq;
       public          postgres    false    228            �           0    0    strecken_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.strecken_id_seq OWNED BY public.strecken.id;
          public          postgres    false    227            �            1259    17623    test    TABLE     l   CREATE TABLE public.test (
    id integer NOT NULL,
    test_var character varying(100),
    image bytea
);
    DROP TABLE public.test;
       public         heap    postgres    false            �            1259    17621    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          postgres    false    225            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
          public          postgres    false    224            �           2604    17572    custom_poi id    DEFAULT     n   ALTER TABLE ONLY public.custom_poi ALTER COLUMN id SET DEFAULT nextval('public.custom_poi_id_seq'::regclass);
 <   ALTER TABLE public.custom_poi ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    17558    custom_route id    DEFAULT     r   ALTER TABLE ONLY public.custom_route ALTER COLUMN id SET DEFAULT nextval('public.custom_route_id_seq'::regclass);
 >   ALTER TABLE public.custom_route ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    17612    pois id    DEFAULT     b   ALTER TABLE ONLY public.pois ALTER COLUMN id SET DEFAULT nextval('public.pois_id_seq'::regclass);
 6   ALTER TABLE public.pois ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    17585    rundgang id    DEFAULT     j   ALTER TABLE ONLY public.rundgang ALTER COLUMN id SET DEFAULT nextval('public.rundgang_id_seq'::regclass);
 :   ALTER TABLE public.rundgang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            �           2604    17679    strecken id    DEFAULT     j   ALTER TABLE ONLY public.strecken ALTER COLUMN id SET DEFAULT nextval('public.strecken_id_seq'::regclass);
 :   ALTER TABLE public.strecken ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    17626    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �          0    17569 
   custom_poi 
   TABLE DATA           f   COPY public.custom_poi (id, poi_name, added, punkt_geom, added_by, stadtteil, station_nr) FROM stdin;
    public          postgres    false    219   �G       �          0    17555    custom_route 
   TABLE DATA           ]   COPY public.custom_route (id, route_name, added, poly_geom, line_geom, added_by) FROM stdin;
    public          postgres    false    217   /I       �          0    17609    pois 
   TABLE DATA           d   COPY public.pois (id, poi_name, plakat_nr, stadtteil, rundgang_name, added, punkt_geom) FROM stdin;
    public          postgres    false    223   �J       �          0    17582    rundgang 
   TABLE DATA           \   COPY public.rundgang (id, rundgang_name, stadtteil, added, poly_geom, added_by) FROM stdin;
    public          postgres    false    221   "P       �          0    16691    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    206   2Q       �          0    17633    stadtrad_with_geom 
   TABLE DATA           O   COPY public.stadtrad_with_geom (station, name1, name2, stpl, geom) FROM stdin;
    public          postgres    false    226   OQ       �          0    17676    strecken 
   TABLE DATA           U   COPY public.strecken (id, strecken_name, stadtteil, added, add_by, geom) FROM stdin;
    public          postgres    false    228   �c       �          0    17623    test 
   TABLE DATA           3   COPY public.test (id, test_var, image) FROM stdin;
    public          postgres    false    225   ge       �          0    17392    topology 
   TABLE DATA           G   COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
    topology          postgres    false    211   ״       �          0    17405    layer 
   TABLE DATA           �   COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
    topology          postgres    false    212   ��       �           0    0    custom_poi_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.custom_poi_id_seq', 25, true);
          public          postgres    false    218            �           0    0    custom_route_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.custom_route_id_seq', 1, true);
          public          postgres    false    216            �           0    0    pois_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.pois_id_seq', 32, true);
          public          postgres    false    222            �           0    0    rundgang_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.rundgang_id_seq', 19, true);
          public          postgres    false    220            �           0    0    strecken_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.strecken_id_seq', 8, true);
          public          postgres    false    227            �           0    0    test_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.test_id_seq', 56, true);
          public          postgres    false    224                       2606    17579    custom_poi custom_poi_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.custom_poi
    ADD CONSTRAINT custom_poi_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.custom_poi DROP CONSTRAINT custom_poi_pkey;
       public            postgres    false    219                       2606    17632 $   custom_poi custom_poi_station_nr_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.custom_poi
    ADD CONSTRAINT custom_poi_station_nr_key UNIQUE (station_nr);
 N   ALTER TABLE ONLY public.custom_poi DROP CONSTRAINT custom_poi_station_nr_key;
       public            postgres    false    219            	           2606    17566    custom_route custom_route_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.custom_route
    ADD CONSTRAINT custom_route_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.custom_route DROP CONSTRAINT custom_route_pkey;
       public            postgres    false    217                       2606    17619    pois pois_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.pois
    ADD CONSTRAINT pois_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.pois DROP CONSTRAINT pois_pkey;
       public            postgres    false    223                       2606    17593    rundgang rundgang_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.rundgang
    ADD CONSTRAINT rundgang_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.rundgang DROP CONSTRAINT rundgang_pkey;
       public            postgres    false    221                       2606    17640 *   stadtrad_with_geom stadtrad_with_geom_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.stadtrad_with_geom
    ADD CONSTRAINT stadtrad_with_geom_pkey PRIMARY KEY (station);
 T   ALTER TABLE ONLY public.stadtrad_with_geom DROP CONSTRAINT stadtrad_with_geom_pkey;
       public            postgres    false    226                       2606    17686    strecken strecken_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.strecken
    ADD CONSTRAINT strecken_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.strecken DROP CONSTRAINT strecken_pkey;
       public            postgres    false    228                       2606    17628    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            postgres    false    225            �   �  x�mҽ��0��y���E3��W�8q@B@AAs���\V��d���x1��l.���O3�A-����>�SZJ�yx�&�=�)�jp5��Z��y�E����$t6�!f��M�b�[�����Q<~\���sZN��yHw��	�,h��tʑ�$��:�!�=zﶎ.(��czI�!ͧ)�Jb��2Ld��*Ni�SRc�0���S� �/k\����%ښd��b���Xhm�wԒ�Q`-+h���������ޥ�����?֕����*�l�^h92��/\Yf�z0�hˢ,�E3��l}���s���r�^��k�J3��ki���{rWЇ�6$;��,�ŗ��8Mi��<g�����2�%%��j��u��io`����2�D����m�T<VEQ����      �   B  x�-�1n[1����@��(*�D�ݲdȒ�A�4hk閃��X%?s�O��?mO�O_�������|���y=�8�������kC@��z���!�C��*�����Y.	�5��[	��bFf�>[���*7�h
R�,#o#�ݓyw$Iu�|��Q
��C��D5;�������0]N�E|�ؗ��V���Մ52�-�܇�C��-�l���XN=�d�[쎕�[��݋p뭗݅j�L<}yW�.�:�<gj05�[c����|r���|h[[R�=Ϗ�aP��7�&NQo󥵫A&\�4b�}�o;����^����v�      �   �  x��X�n�F]�����$����g&nm	PdC[�%���rP�L7�������Cʎ��J�Z�D������{F���΋]�-�6���m��e��.�eSt-"
}������/���]��)�D1�3lfg�,[`>'�p*&��?��.��LZǂP�Qα�$��G�s�-�g�)�+��?/�B�9�Sq ^3L��J{x�r���\��}ܮ�U_��m��ܮ�����uݬ�Vه��_H������D(X�ω"#!����^?|�Rֳ�U�v�MY#rʪP���1�HIOBx#��������	��ժ�KA�	i@[��J;�f�L%S���y�q��FĜ�����>ϩ͕���	~^����[u�(;!��rI}�AQ9�A��O<�S�?�UU�v��o�|Yon���Z���Gt���t!�3)�!��G�����=3�M�b��wE���ٛ�﫪��|݂����~o����DKLȡ)`1��k�$���P�o�Dn��  ����esS P��4�ͦ͠Yl���v�����փ{)��*�Z��DK�MY߷�� u�_]>|�7%§*��4�#�V��q�3���C�y2!�ܕ͗�бr=���.�&��1j�R�L�AǇ.�'ĵ�ikC�\�L-�I�9�R��hڮXv�l_�6{�Zu%���0t�7yD�U�1�\Ny��N���a��Č��*o�0E����M	�[���GU[��f�S5h*#hp�O3b0��^4W��:�F�ǁ�2.Ʊ�<�L.������(ߤ����O����S<�%M�y�&frV�k�]��º�I�����.�<�2pt� ��Ն1q(���0�`p9	=��.@�b�����7eu	�^����)�����SC<��!��d�������/��?�V���AN�FI�St�`<�6Z��^��p�ӵ��"&N5W�0�V���7ٖ��M�u�u����-׻vv��U��]��)���%����9I�J��� ������m���7����Fb�Q$���+4�MY���|v>�\m�?Bc�PB�\`�e���|qZ�.J
6�|zj�~m���|������n��G1I�L�C��@����\�DEX�Mn��� �>|�g��u�����容�����Tį�Ċ���A��R��Gr'$�TrO�.�D�!�	��!�X�-�F�Ă(.�d� �~��'��^P:א±>48F� f�Ǥ^Fz��~p����D�?�-�'�L�_�!~Q	�c��%{3>2��2ǘ�0�葇���h����z�U_A1��C���+(���Ri��3#��ʴݎL�	��5s�!��)��#U����Řko��*�3,�ez��S�a�*X�*y ��U�KGbe�����}������v�      �      x���1k1��_�?� ˒me�%�B��]Rt(��_�|{����s����ݟ����}ݾ���  �A�('�W�W�%.�@�c<��X��2��o(Hܐ�i�JP��B�X_<�,�M���WT�z4��ŵN��eo���#�l�����<�bB}� T]��&}��ݿ�
հ�BN�f�(6�W<�P�Dj����j�>JN.��;����~�\d����[��9GK<�q���[�o�?����A`d�      �      x������ � �      �      x��Z�r�6�]3O�/���`	���؊3��*5J��]j�5��8��j���3x�]���d+����*�\��ˋ{�9���R�ﺧn�n�}���_�o���=��U�W5�����A�?���&*�B4e�梎��^H/���w�Z���f�����j�-����@k��x�� (�2�Hp^�@�)�#�հ��m�M���g���Ԛ:��Q�Z�����n����e��i��>W��m�ܾ�nB!	�1"*�#	3��^ ,\7L���m�x�)%%��;k�U���	��Y�u3c��/��~��|��l�pC���^w߈�q���9+���0�yu��19��rs���ݦoﶻ�#|d^����&&x���,H��)�+�Gd��������ߑ��A&(�	�2��%⟑y��9�����?Ky�
�5��7f,ˬ�ީ8��\�ݰm��u��y���1�t��-U��1.�(R~�L����[ߢO���×5Ї���'#�����2�c�r?'#Տ�m��]7�v���V��W��+�����}7�{>hV�(��C3�K�#1V����f�_�@%�]Vwwso��3�q��2�c
�SK�O���b�������}��/�ß��Sw_��A"*ǔ6U�����F1=#�ʮ�z�9|}z��S�� +��A
a� l��Ѧ��3X��ׇ�����I~l����Ń�Fص�<s�d*6�5�L�A>�.Q�������ž�F�HB5Q�fd�&J���D�������q�?n���ò��n����~���i$��9�9���s&z�"oܩ:P�����W�jw�<�������b�1Ϙ'��!�)C�P�H�| ���v���-��u>�(@)��}{}_J��Lp�p�#�țԧM��ϟ�_�l����%~��!1w<���ڀL&`Q%�o�cj_+���&��h	ﮣJ��C<v���E:�E
s��T����=w ��<�Fkn���(�eXmw���j �Uq��,w���D�('�I"7����QY���V[0����ʥ��Z#�1ӄ��X���9��W��|���I�H�QH`n5/�4"�Č**���D3Wݹ`��5j!�&�d�:�n��(��n��K�?Q����:n��`�Bd�d'��E.���z�^v����n�����̉����\�4	�DΡO�|�F���)h0��6��` �W�ö}�-Θ��`	(6+���k���V�����77]�[�O������E���`��F��,B3�9lF��{��nᐇ���,Ge�vB*#k��V9�h�����9Cy�Yv����

����
�S��v��,G�7�Y��>VE�N"�O�	sd�6J������˧�'�����爃g5�q�z�9�˷�pw�ֆ���Ɏ�";� ����I��VG�]~ �&A�S�,?���������m����J(#�2�(�o@��^�ĈA���^w�XM���x�f.�L��k"�1��d4��"�a�g�[D��[����b.�+�T�DLM	PG�C��3 �{0���B�ET���D% ��X�����~^����F�'����%�4SP�C����Qe��[�Ow�m�q[���U��᜴'1�~c#B��Tg�n��p{�~	ԋ�Q�I�?�����1~�<fI(�Na2����v
g��K�6�*����p�ރ�N���om��#��{�$b<|���*�TIE��R�aI����9��.��}\����_��r�N���+&��鄔�JxLI'�aР���5ۥ_�ag�[���RC�<���25��؉s4�<����,�%"hӰr�k	O����A)^>1���c��M_��H��m��
A���\)I����|��r��<��OC�8%9)��.���� �6�bf����T���A'�;۞�l�>��L���	-Cn�cnr,L����G����_��^̍����A�M�,�W3���� ��S!��MF༲K]�����VbHJπ�B��s�!�oPm7S<�l[�Ռh��i�����	ʔ��-F��{t�C���?��@�D&�0h�HrR"� ��[����{|:+뢽)1�c-Ɠ��5a��J^��������k��&�,�\3|��Ϥ����z��U��~����}����GV����AQϯ�;|ũ� �]{���?Y�"	q�P$u���X%�tT;1ê�m����#�h��m��(Y�����T����#2�����S�W%S_w��R*���64��e�|-���P��z�w_�������;vnq`}�]��y&�R*>��h�����^ώ]��x��Y^\�d%�T�x�PPC�~�g���g��j�J$:*������8n'h���cu5����L��TZ�n���i:��8nGL�Z5���QF�|�lʸ�����ﺱ�.��V���ru�$�Bj� k�,s�j�9���K�|J}Q�]�1�Xˣ���B2���Û~LM��ݟƫ����d[N��,	���nj�bFu{o��M�����L$�S��ç6�[�Ș��a��B�Ь�;|�����h���h4'��i"|�^ד�s�����i=���k��{�ؠ
���jv��g\z������??vdɽ �jDs�F�o乘Īw>�����?�c�z���:
�i�0(�芜b�iވS�����̛ճ7(�����Z7��~Đ�Ԛ�q�	��5����K���,Lx��q�f����×;<��辉Q�X���"B 1𞞄c;��~{���G�����f�6�cB�4󓢞������l��WO�������6����Mc$�Sz�е1F��`B'dV�������[A^r�����ZDS�2:�v�,�������W�?��i}~�
K��[ahP8S��+��5\�at�®�_�d"����"nn.�,s��(�F�]���9����b7iy��m�Z�o�y������c��x�,uӬ+w��r�����r*Vn�e�U�A�@��7�����k�gS����r��s�e����Wo`��n�~s&�0��.FyL����.�%�(
F��j"��l���cD�f?|�����:��zZ����.h�C���qTQ2�]`玁�c<ގ�۲W�M�z�_u�>�#�%��<`�F�T�'ʡm��5�s�?]��n��iH�E��hE�G��H��S�C��i5����j�UG^j�}{�FV6��H�&��)ёz*���:�|�Y/DFY���%n�u6'?m����������8��{���g^T4!�����&o��N!I�Ό��6��i��}Q��*�:������3��O�Jz$�aqD͹=>#[�R_#�,��d��	B�����#�LwBh�eZ��G��,�/��a�3RjE+4\>����/��`�Q��iu9�OF:UI���zUN��V�ڴ���
I!�je���ʐ7����l��W\b��ݞs�~~�������G��n!�������s��$�e-�����t�&i��Ͳ�֫��
��ߏ�jy�����6Jf�?[�M��|��w��O����(�:N)k��1dDC�'DZ-gD^�o�3�z�������Kc�媎�����t;���#[��B�ŏLg_B%(��B�)����_n�r"�k�����]�9 ]Ŭ���LR��
B���4��y�^�O<��s�Ǽ�_!�yn�xjV��| A� ���\^�ér΃�Yt��V*e�Y�"���8"t��Q�Ͼ�)_:L�F��űSaUұq�f`Y]��
�>�v噀��'�AL����2x�Y̪����\����������x��5D���a��q�.m�O$S��f��di��¹b3�0S��� `�u\���w!��Y���]�P�_@%C��^]�W����:_���v���wTH��\)2#�a?nW�|����-�w�gE�
�+X)Q�#�� k��exEx���D�v��o�~l��(�r#�j�����)�Xg檀��y�^j��v����e��r���1c�q��"�Y��a��}����� <  �Q�RD4ɨ�N��q��xV�������6X�wyRX+Q�b�	� G� ���=^U��%�S"]��#��I�:��1I2�1hcf{ê̿,
�I\�\����6����w���+@A����i\k_\��U��ǣK���c�<8�'�L��1�O�a���M��vC
���v�SS����MTB������L��W��C�}�i���}Z��Ϡ��F��&�9 �����?��������_/"S��U��Uf���@0�w2!kX�3?�~^n�T�#�}#b� R��m$�M93.=},�l�f�=ߧ�E)���_�l��D�3��q�"�W����b�^~��֏��E�~���*��[9gǭMcD6�q`)!�4���cIF��I޿����Y��o��qGA�s�F{7��@������fۯ��q�%���#��'b�'����x�1��a��M'`6.%���
��~ۭ�S�r����L|�������\:a�Dm����p�r�Xɩ�����E��+ʡ�>�&33�s��<�!�i��C�_�ʺ�a�g*��q�T���+����w�}�����X      �   �  x�=�M�1��ݧ����Ol���c�ذiDKH3b+8�b$Uij�R}��{v�����ן_�o�O����y�������	��+�����.o��oH��|zN�R>�>

2�CJ�y��x u��U��s����킺��e%h'F4mq�XJ����i�FwG_<̺G'�2�'q�C�(����7q�!�e�@�
U=y)�179�i.ELK��8�0vl�>O�4r��m��u��2j����Í,u�~�f��Pԓw�,t6��u�w����ޅ
m5r/�;�g̓�A����ƒH��Y\yN�\���\�IA���`�VK�����O͕l�G�[��;?@g[k�����M$�VB�9���J%��gMZ�F.���C�����Cq���o笣�]?���s���Zٙw�������A�
      �      x���I�%�u^��`�PE ����VS L�jx��7Iɴ���{���Q ���S�I������/��O}�_���������������?����_�u���?�<O��SS�������F~_^�f���������yS�o��5T����{��7_��wWx7����Z�m����:�ç��W�srȑ��o�!�wp���������sv!�2�[zy��'���7>���Ɠ����.��s�9��%��/����������W�����	a�Pv�V���ߨ�{�m��6���
��:!�?�ٞc�6���_������W�|��?R����uҽ	�����{�?�������s~��g�{���N��g���9��n��P�]���Xި��t�i\|�����{L1�Y�8�����J�2�T�5����Y�5���!���A�{�r�)/�<����'�����m��}��'S�Z�o���u7]�Pr�bcr�x�/�_>Ū^	p퓟	���
+��OR��o���g�����݃�go�n����bxc�,|,)=�?�[�O�=��B�'�_���t�7i=����u��k}��H��-Pji�K�m����7=�O��{��;�����5�ۻe����+Ļ���o�[���ש<#?�r~y��Oĉg���f�Y��u�]�<��Ծ�!�-���h{����7c<�R5ֶC�9�w�=�:��	�ϳF��{<�?�7��N����i�_FR����ONc������<~+��}{Yu?�ͽ3�!߫��;6I9~S��+�A��z������ߧ������9�t���������g�S���������k�:���Z<Q�y�=Y�o������}�O�g|imԽ���:��_���Q�P ύy�'��Ƣ�oՉ�h�u��Iq��#v�c����Z��>s��O�ϛk|��Z|�J�v1:�y��l�YH�BqT<K�3����1ߑ)m��μ:��we`�Uv!��5���E��0��\��r�e�]���v��!�So�����������Z�cB������҉i����U�d�o9�7t.X��$b��Y8N���a�����*�c}���������L�o��W]\!s�z.��Y�}X���͏ulї ᬟ��lر����U-_D���S�Ay}���_u��WE���)�#�i���f��>���5S���m~��y+����D4�����u-���8:�q� <>j���\f>�æ9&�B����'���5V�N�c���^�o=�ԁ:2�!#0��}�9�5w���D�VGxZ��q��z�2����,�����a��@����z%�5A��w���2F1��(��73Χ�� �{����S>��.LC���A�0��=��`��T�`�������-�yB۝B��hk�[:���
>q.O�f�|�I��[a����*�����f�VP�ޑd��)�_��"KVV�@�Xƅ6��~�Q�rm�w�}<|���c���a���vnC3�6�k=h�Y��<2�	�AUyOV]G�~�V��-L�tRu f_���Ho��K �V�g����؎*h��U��^��W{x�o�$g��ƼNq'�Ŗb��p)���Dp�X��ը�g�*�7Epsk�K�j��441��C��~vj\�! ,F�1�6��C
��=ٯ��/x�����j aEf>�"���4�]���&ʽ�3��B-t� v~�}�mIx����Y��?ڤ=#[�"��b����"a��W�����6���x(�뛤w��'6WH���`��ӣ.���{tH��	����X�7�i��`��?^9�*��f_�_~�;d�(W������}�C?�q�oIg!�<��q�SAG����v�@�{e\m`q�1h]ض!7Ѐ���>i�����Ȕ�������X�[�OG����V���]n ��Əc�'��[��Ó�F�ߙ��#�@FL5�g~h�n�j ��c,
F��7<��'ژk���0߽�QL>��_�步.�o���O�r����gmL���������4^94~Bޱ��`ǰ���@�� �3
���4��<�<IA�Gp�|��fu{"pS�`x�h����MW�z������҂�`-�=�Q���ql�w�/�@8͆c���,�x��`2p�MZq8b=��ζ�N���=��P�xh��M��ѸUqm����jO�pj�$���b`��N�"]P��`�c�������3��.���<c��	C	$�+���d�,7��`�^F��C�8Z�;�۵�jq���b6��_ ���HXU�5�qMX{4�w�4��7�S(�ó4����*���a�����G�� ^6cPD��-����;��8$<
.�7`!N�]�-���%[XY�s�ǖ�G��'U�Zb�`��h��7p����7�!�0�1�����_���d�:�X��� �8���N���^�����m���d���,�B�� J6Q�4\'˸ ��7 ��v�m���D�
%.����.Ao8�?��6C�ء.>�(��v׿�Q��mƇ= �qP��$MyF��f���@�̯�q�T�p7� ǆ�����|>1K��"��#�y^��]@;�Ȳ1��}>�p(D��W(f��@{l���!;b���`E��"����B��V�x�h�\������fup��:},���
�X�[C�P0���.,~�Xw�X���%-�i߄I�cA��4�M/[j�L����M���~�2V����1x:ш�;c�� ��@�a����5�zCA ���&UPa�3��=ڦ��`\���E��s�	�cP`�=��CM���d @��fH8[v�ʵ31UX6���ĆƯ
�06���!�v1;�z�H����WĮ_��1�n����}��Y@�3<�K�}#�0x�	=דb�p8p�Ds���3|��N^��y��� �<�+!p�7�������[/∽@�Xc�4Jzش����+��q�P*����$�?��# ?��
�/�s����аm��3���,Ov����Q�4�6a�	y���C��?N������¶���(�[������U���`Մ��*��g1�@����4��ӥ`��<E�_�����H,�6�c�ˬ��q���J*�>~&�����b�ʬ8@>
��%�zA��L8��/�pcB�����$��F^�d�4�Ng���/;77��By�h2J8p ���^��ubH*�/ʬ R�^���$��i���m~Q�R'�\ *g��r�⹠�?V����*b���G	d�|٤	�a>)Md�V���1�r.) ��;*d	�_cq�٥�
��@����Dd�7����	�4 Vc�qL+��&FhpCh�@�K6����8�Ǝ�%x��&���S�`�rf`W_��)�����Ya�06X&����u,H��5l�[���b��x
�ii�T�� �h�5F3��W=��	D O��R��^:� 7��x��x�����N�n�R�i!�5�ȍ̕��eCd��'$)>���#��z*̜�/�,t�R��C��U� :�b.�� �����B��|Q��
/�}��=\r$�G�"݈��SǇ��<�%NG+y�SywP~�#��&��@����G�T��R�eYȱ�ziＢ5`��`C!����G1�������=΋�TP���5��c�[LA���xuм��+�.� 'x*�'C'qg�B�og{�}z悈��T�i	B������f��C-�jB_�g|��b�@��������h,Ԭ�˖7P��X�bl1&-B,S���m=� v���"��bߒ��ށ��	���8��-�Ż�_�g�L�\�<\�'�`�`Y/z�"aV]s#D!-h�j���O�(ӹ��:��JVY����P�5Xo^*>�c�au�<�%�!�Xs���    �,�D5�6�É�v�Y��F��=�NXte��B�ˆ���U��.`8��,��Q��Ň�_�#{XW�s�=`1�z!�g��dLޅ�:�MK>x�i���oBG�����V�'�ŒfV���S�'�#���;�q"�ZL>@u Ip�u�(f����y��T�b�x�y�{����1}/~�����0�0�}�`�t�^�i�4K�q��6�X5�(n��{��է���/�8��z�(�0�xzk���2�|���m`�U/�-����[�@�a��Y.$�΀gT��C����=#e� Ф�*��|??\K�;f���F@�YC�y��V`�����@��Y^��|�5��D�.:a�3���/�?wY��7���U�:�����#Q*x 
��1���D#��������FC�8=bN1&���u�1��2�]y�o�F�0���a�P�a�c�(�
�~B�X��Ʃvh&�(J�Aj@G��G%� H�+�g5i�b��G%��m>���, 誱YO4������o��]pk��g4<���K�kkfka3�]1?��E��c"=��6�XI3l0�����SQnv��֍�| 5n��&q�&;�tG."���ycNjy�.Pnx�R�g�D�,�/�&C�鄬o^�W��ގ@@�bo-�3k��n��Z���yd�21�� Q}�V�'0
�	:O2���᱘ �^&�b�ӄ �+��Gv��ފ��	�O�<7Dc6+��h�Y�	�N�%�<bW�lR��5�d��=AN��i�q��҅
���X!��|�8q����7'`C�X]\�}_F����6yCzyo�5�`n�s������"�� P1RLN!�F�`̀�┃1�q�K[��4�D�'}7]�
;\F�_Ø����V;@+�4�Č����1�lY�UC�/\Ǥ̗uon�vŸǖށɾe��L�K|��n|gn��M��� /De���������	(FO�#!|�l�J	��?f8+��a7�`rj�|̛X��w��40Ń�qmY�h"St����x�b�Y�籫�5��jW��\��~���ן5a>�vW�@h��4���Ŋ���=��J����� P\hl�k�$�-��7$�(Í� Sx���_���a_V�ܵ�F.�Ut�a.Nn�������3���q6���k��k5�A��:�.f��H+6���j䊋�l�BNy�$�W��/2�� �@o8�?�SzPY���<��]��3\' ��o�Ս�0 `0�# ��<ó���p?���f�&#5���� lXԀ�"��ŢOC�lt�F]J��f.Fg���btp����`YA������]�)2�����˱]�7��Jg��YF��萈bɗy��a# �%��	�������2�>��,�J��\,V���8����Fo����[;S0��un���	�����=mak�YZu�)��cY�H��rb���âb�O{��x� �ό
/�.���M�a���i�Y��B� a�	V9�ti+慧�����7v�^Ǯm����T{ň�J�w�y�w����!��56o��6���4#`ɉ,c_>���5K"��%u���^15s��'��u�I���nu�Z��,:�;"����O�;oC�`N���|�u˘L6G
A�F�`&������jұ��uY�� ��5�f�B'���9hFx�!�|�1H=��?~Ím��@8�`�-�a���3���;X<��ݜ\����ȴ�{��s5(���Ll�����L�P D9/�n�_�Xㄠ��_�im𝛎�:�#���A�K���6,'�qp|��j�����mĆ�&Yq�b�s�)(�GǍA��ϴ~S���<�����j��qN�&N�`l���d���9�K��!e��0�g ��k@��l]�"�bǇ�?f@��n~��~i��/g�Nn?��B7`u�"�
k�o8��0��ܟ�o�X�f\H��Eđ�˙&8+4��,��7  -Ŭ�(��<�ί�0�V?����WC�ې���~`*�K|@�cI'�t�/�X�3��Qr8*ոa2����sxE0ސ���B���u�t����Y�h@9k"�wl��|�r��f2wYU�_�}�=t�'�K�-/Cwp��7�f�zcI<,���Y�� �&M�/q�UP���CX�1�X�,a9�,��a�7��lɪI2#��p�t�r[�U�
��X�+k@Sĸ�ِ#p��p9\!�;[y�Y�����w@���dt����H�����f��t�C��ě]Ta��/n���{o��f'��Z�w1Ižj�a\�qtG�,�ޏG�#�Z�Jae��A��%-l,;[�E+�q
/^7,���VI���	k��aV��႓d㰥8a�[���2�
X�a5��c�z1ʁ�	1x?�T�=����O+g���:��a޸�h&1#�1�:2� SЌ� �ٿ�XE��lDT�~,=d�����,|�3A�0�L��!�fu��\��X]��>��ڌ�Ga�>3V�5XH�Z���ɜ�R�[ڀck�T�e`�Q�cXD�8�tê|��0��:�	�e�W���eض��Y��{u��Z-2�Ph��7�j<(W�@�:�#�� �"�{ѭlI/U���0���\��[�J`��+���aY�������7�6��0���
��>Bunh����� ·�[����S�+�c�%^Ԣ,sD�8^���pH_�}��/d�pF)Z
�@>��Z�K3�	�Ŷ7����X4��B��z;!�+łR�o�ɯ@}���\�� �b�M��=�.��f�<��a�����/ �ٺ8�)���p�Gǣ�H�!>+o�2F��4�� b�a㬠��¸ѭ`e�ן7|����P5s�3��>�/8��)�amj�߂V�ti���˅�gv��K>��	�7)�>�8�r���`yU�F��9}��]�"��,xT�z��u�(O�$@+�L����G�:�&������HP��Оj4�Z0x�R-�c��5<,��*#P�e�2�
���g��=�"�8|7��M�[��7+Nog��><J�o5 �4� 4K�q�Icj� OP���
Q�Uk��E�5��S�/h
��k�h̯ �_-9���íj���4�:@]U׫[�9��,j�pQȑ���`-�I��1B�_��P�ϙ�<�H�\j%�MOa�^b�`�ky������-3ФWI���#�~�����~I�����X�5�%�j}�cpPی��1�r��䰹i�H@���b�*L�~=#T78(��FW ��H ج�Lv64�L� �t�A��p+�u�(���+�8� �1�^J́���Xx.�6ظ���~�ԛ�7Eem= Z��k�඙��n[�'�b�R\:�i}�Y��z�t�XL8ُ���$q��Y�c��{S�����@v#���nxeJ����L��DV��hKɗ�瀖�>���4m�P�#I�@e`��3M,~�����D=��2C��N�!���ˇY��z,iy?��}�~Ԡ'���w}k�(�,�LL6��4��=�h��h,nh��U�ц��D
3�n��ƪ�k����ܘg���s�h�����#�'M̶ژ��j�����7t����Z��Z~�m�0�2nM��)�O	x��u��T�p�:�
��$Y�`��B�7A���c�xЎ�d^	��̞�U1�R�,���X�i��V�*C@hAn a��1#c=B������(�a��u�A ���k69����uU�3�Ԥ��t�󷇥ww�����p*l .��bU-�4{f��	5zo�+$��X���ҭ�l�O����(�}�S
�b`�2�&� �ɽz������kjp�pz��E� 8���	��,��˶/X��^0�-=A��kD]�ڕb�Th�^�,���Q-�ܘ�e^�P��i<    CJ���`ܲ�aD���^��<���œ`�c�A�M(���!�F[(&kS���g��6f������E7�ll�qJ} �^�hG��q���AofbHWh�<�z_S�[���J�P�ϒ���Ӌ�g�a�@��B$�)��;��v+Z� �P��U�5�)���S��&��^*�<��u��3��B�ؤ�*�/C����g|,)���x��H\���Rx�\0 ������J� E+!_Jy?�ٶ�T<�cY8Co�\�����-X����m
Ц�!3�b��b[3��b�xām�N}���k�.�א�����M��&�t�mE���`Q�H ��ź�7�b��>�j-A	i�Bq�Oj�Q�ȍι�ğ�F �o���̜����L�`���J}%�Xlc���(1�ϭ�slܒ
��vrE ��o����-8��&�c���(z�v�4� ��a������ E��d+�qo�u-f�N]Z��K�,@N�B�BL�F/��"Ⱥ@�,^�"-h�ZJ3��_�. �~�<̀�=�`�}�{]~�Y�N��f,n�V��G����f.����V�^C1-�d��pg���YG�g��^6���h�`2j���A���.������N+�@-��c��=@x5��S��yL�|(���:3m����lc�
4� `�`�N
�����̂��6O��n��cv�%��<�!#e�%+MD̮g�>��	�gA&��[`��������~�4j0�o��X����o\��9�]:V"��X�XA�8� �{�w#;_m��M�#��lao^,<�nl{�wo��C���6����� �uY�i�ƪ�~gU?�)c�h��f���F�<�k'f�5�֬bGk�Ր�Z���������W��.;��7(��7o���4v�³�qM����,v��u6<o��ZRq�����b��!/�����T6my"��a�6��<���	;�����]Qǃ�ek�d�H���b��Y�Gŏ���#ߦ�^�{Y�w �����dB� V�������rgG�p &�9v��EL)�i�Ux��$���i}%1vy���M����|���z��F�Y�X��T��y�'�e���U�����Y @PG���)�|�n��� �?��e�Ijp��hZꖖ`*�g��a�����}�}�<�h�zN3�
S ��*�m�=�==�_e� ��YB�mJ�ۄrFˈO��]��0�g(ȶ�����|pZ�o�6��T}Z�/��ĚYY�r����_#��&8Z� �p!�p�!��}�>z�I�co��l�,ޮk� �z�?�i��eX����tHK!�p	ȉ��f�â���U �����e8��i,����-�6��ф���}Dh��d-������zy����~�w��\�\N��d��-C$;�.�d]�+�0�5wB ��}����:ll�<�������zX�.O���ҧ�x�D>5�Y�� �bK�?x
^�X+i![ât�4o���{����n*4����m�<���-�����b���=Ņ|Q��̢֔d�nAʮ��#��s��-Urq�e2|.g|"��HPA@� �80�a�v��)[Wd�ۋ�}�(v!`�X ��	�O�[M�Z��n	��x[}e0W�{־"�
�B�EKI�}�@>@=^�}�Ն�h!\�����ც��?��`����0���8-�2�nv�3a��Vqsۗ���(�,�F�`�c������<�M��2�6(�����k^�5�A�J�e%�M��Ԋ����d7�k9<(/g�d��	`Ee}d{��c�hH�}�u�Хf'�	�b�9�|��x��
�P�mڷ#E��}6A�a�ʺ)vX �ݶ���8Y�hPԆ_~A6-�=�A ��?�n*�B�t�5J�����܆Պ۞ȿ���B�)�rA�Z�Vl����.�{k4P<���ٍ&E1��">TޮO�#/��xl���h?��w��h�������2�T-��X��/j�,��`�݂c��q���ݔ,������	"T�<v�ګ>���yHy,}۰�<�!y�ن����eّ���  6s*�^�^_*�rX���e*����#vÆ�w��tl�ƶ�.��������� �di6��+�S���W�A�V��7۳������ĩjp�E��ڽ�H{���\�_jǟ�/$������ê�#q3������n)�������.aA�'輾n#~c[M�a*졽͆�m�_ʠ�D�>|��JN�A"��E��Щ���X��v�UȬ+�g�����u[P�dv��%�D�Rp��ΟE�&�?�nd��נ7�������2K���� 5�'`�,�8�aC������hIbh����D��Pf�/ ,!�@�<���,t�z����va�����N����0�~�Ս:`b-cZ�Z���q;P���� �7���f�ד��l˵�eY�6[y>x2�WØ~S�ݙYL6��ɚ�BE� ��d�}[lMg���֪ܺ��?''��
��;=:zỬ��+	����}x�J;��CI����|�(�2aФ�[ڰq[Ǟ�M�D4{�jӞ>6�'nXn����� y���o��xQ�U1v	}�M�w+|Щ�@9+џ˧ ��,bXl=�_����� �`<��q��-X���bE�ݿ�ͫzK���ySc&#�m�"g�t� İ�/u6Q�+o^b@v��*�as����d6�൚���.P����Z\��~��έ��ٳ�6V�
�� k�κ�I�	�wX��V��q��9~�AПI�>�t!��0;�Ѽ,�AdsP�\p�� �?,A��Qᜌ�Շ�R,��[�e3�徯�br�t�L/����+�b�?(����[���>��Fe�:�G;�Q�F͛�|���7��&�b�>��V�"��VC�c��y0�IA��]5 c{�,B9�ȆxS_�~��O�\@ �^v>p�@rV�C2q�S_o�j5|��+�W}wEìp��w��Im.`��1�Ω�!�^�� (��Mi���E糤�e	����y�n��(.���ZYV7�v�HY����P�jco��� ��Hz^Wa)��|��0�A�%a|�>�OꄛD�o-;�uJ�Ֆ�|U��B`^����]ֱ��[sh�Q����f��K��@��V�D�\�Y�S�L�Nr$E��_���S�\�CQor^���7���a�l�K;Ֆ-��y7�E��骽�B;���[5u�����>�o�VAܚ�h��n��@+l���#8�j͂��Ҏc�U�zΆ���՞?԰��Y�fWQ"�.���$��l��#��3�#�pL�G�Y�lM֪+��NV�R��Z	�{,bI�V�x�t<�gh!Q��1����ߝ�b�p1�)S����&n+'� �"xj�s?�{9���p�!�\��-K��߉)�x�VZ�q��O��R�i�ٻy�l�7m��R팟�77�\VV���q�����(��gg�Z��X�3��(��x �0oh��<��-����@�� ��D1m�y-������3�{<G�����B�>N��.pʑx<&|�m�~;@�}c �q�h*�L�[�
�5pm�T��t����
���L�n�����p��c�Da��w��b���!�֊��ν�1��m ���EPk�Ӯ3�0�cX�g:2�WiSufL�˯^��������#$t]j�3p�#��<�qr׸�<����Z2�`����y�ϰ�#M��1��}r83�vJ"���ZJ�8ژ�Md_�)���[�e�F�������bm�w�_�O?
.�=Yc<H;�"5j�7���ƃTI�n�����Ώ���p:�L���tK��L�9���F�Sl��C�yn������Gp"�B�lX�mnxAA��r؁��d�Bggس£AZx��;��n�������M�><�����f���_�xPH��A��R    ����qb7J8��4pH�~�y��l�{F`��mP�D��p:�����\Ӝ�����:9���#$7��3�`�c)�#"��c5|LV5g�����75r�4�0u[�%��M#�v?�`�Ph�>�0Q~c,�������� �������hg�D��܊+��z4�v� `HZ5���	u:Q�8SMM��2��buS��w��۹0H{�~�9�����2����(%(�s��ć2l7���Gvf8��c�v'
����F�%���.�l�����

�V�7Gvi@��M5�ľ�����V+�l
&J"N��h'm؅��6u�`k�s	 s�6,�11Pm��U��u�+;�H��]Pª4L���I���<4��D0 a��7Փ���|6�n�����7;v���ٛG�:�܋>�5�$�6p�}(,V�*b',^��rT�Ix��X���0e���K<�g�&����AV�'C��q
6';�:^�V��3�P���2�����j�-k�L�ʼ�̉�0L9<f��;�8~��&� �׎�[i�%�1Z���v��/Jow�m�vaqM���q�jqh�×�'�
W��FsSѦL���8��,94o�V�7��HO�rVK��4�m����������� ��j��8�	�|��4�2��>�����z��,p��mM��ō,ZLvC`V��X�'֒�3�����#MX�=�Wv^B��Ӹ�l3�X0�U��N�I))�&�e2�c��������q��D���L��(P��������0��SΎ���_^c���M��W��W�:B��EιT��V��<Dg�ٳ��5�	����t�*����*��sct(�g-�զŖu0���΢��-�u���/�?o�q�Dj�1�^�S���v$�������<5�}�C���a3��t�tM��L��lY �P���C�U�G�_�Bk�^g���  rۀkl��x���n1�|�w�¤���ߛ۳0˱��ǵ��O!��J�1\�k�`�}�����h�-`��͜ZjSmŷ���}
7����&�v�.W�����I���1Dt�R�e�S/0�7B^���=�!��MT�X���86�M���)8�
İ��j�����:�t�.�^�i	�a1�ͪ}ʎ��Z�iGFa��q�~�#c��[~�<۟���P��7���z�`�c%g�>�&�g@����[�,�Xٺ���I;M�-�|�c���bY|y�5�(' �9S�v����-��>��^-���&��˜k��p"H�;B�_�c���FÙv� (c���X@j���s�s�%H�ga(d�s���	��{h�t|�p��u%�:;��y��f��i8v�7X���%]�eB!�G��ZN��\ѵ�F�F�'4'}�Xv�9P��,����ΆY�m`����re:����׌Br #^�[Hc���l�c2;�z�t�K��<ӱ�>�A��c6���&��.��q�%�"�|�W`]ҵt_5�	x��nZ�H&�>|�{�$xM4kb��J�qf'<���jRd��z�e�nc�nG����)=�终�Q��X"�J��h���0o<o��O�&����\�?t3�>��d�P�3p���^ ��j3&���ℐϖ�mܓ�Ԃ�]6���6��m�����^g�S¹9[�PVw� �"Xg�@7X
w���7�b����N�������9���O�/��k����&�Ӷ#,X%��\o����'��mVy.�q|,&���7�=��Q���n���<"�%�i9g6��9�;d��R�;T�|E��!��"�e9����H�?2ϜV�9A�5�£�҇+�iA�����Z�m�����g��� h4�r;�ʉ;U��<�7�f��{G̃���oǂM<�3U,ZL��*��P�>7�k�b��l��MַX� ����SԶ�â����;�p�Ef���� �되���Z�[{�:`�ŲV{���� 	��@�bu*�e6��4�^0a"ek�]NgXe��	��zx�!+�̹�E���N=���W�:&M|oQkp���L��3+���c�
6+=��y9�F���,��� �&$g����4��є�Y�'�y߲-��3��Y�g���V�`���G/��f��VBR,P,w�IE�����Bȁ��٦�w��z��Ӎ	 ��N`���@�E{i.�3 ��!g��$��#���+hK�_lk�
`�J�f/����`�d5X�l�^���X��8h��t��6�[^��3�y��5���۳$P�.gFY@�f E_0_��z�=��M&���ٕ<>��1��z[��v`�e��rʇ�ճz:���
��4�&���Z�vag����g��ﰗm���;���_�tpz���y�hY�Mv�A/�~̰���X �n�2��98�o�!ɹ�IwD��:��ء6{=�Ԙ�_�yw����Y6�)Q����!�;N[c���l!�۱*�M�6]Xayz�1�>K��X_-=�'u��q;�R�cm�����7ͭ�2����hT֮=eZq�-�^G�3��NkO'�:��i�OX��U���`7����p��ՇF �cl�7�&�o�s�E2+9�b�k�?2���"����Vׄ~��0�[ ��5<�[�o����>�p��x�i���B��d�;����9�MM4�ٽ�(�hI�g��c?�Ɓ�-�)V�m�m5b;��s'�+Cɱ~�azd�[�H1��m��쀪���'w�������eZ�pkV~�+ �3i �)�d��C��}��[�5�p� .��^*�:���o�b�b%5�uGѰ�Ɵ�~чMm��Ulô4~�u�D��dؾvg������j�m�����jC��.�q���u��� Rǩal	�֦���Os�RwZ|<[`O����#������^l|>$_p'2���@��5��:̘�a]���Z6�l%ȁ��.'~�t���d���.�Sͽ���u��T����z+�����c�|�1�\�� ��,��[�|�2<1 ����%�w8NDp��4N�O��s����N�a����OG߯�Iu2�	�D���N�^��jPc��f��1\��\�n�.��9��q� ��ݳ%����-7�!oBz:�z1���n����� ��Yg�w�� >[s��P��1M�	U8,�cA�F/ϒ�k�m��9{\L��o@��xP��J�G<�v������q' gɛ�x�q:3�Ω�?�/��D�`Ŝ�=l)DCv���V���N	�<���^�����m�p�æ��7�FJ�����g9�Ka|�:���#���`�ϟ�X7x��T��kc�	dp��e�hf0 �<�ǘ�P�x��Xz�'ʇ��V��w�=a���)ʁZ�����B�,�CG�`G����b 6iq��ӂ�����]�f���f)d��@A��w،f���}y��c�`͉��<��5l7��ڥ9���6k�7H7�n9�n��-pj㍔7�:"��� Y�ףUV�c]�U��F����>Ab�T|��L�7��@q���4���7���g�h�}k�e6�{�u>�ηLPAkf�=��Z$@�˒\�w�!8�9�i>��P�=��g?ԋp1ޣU�=s���p
��ZX���h�w�;�7[�ّ���^F���6�Ͼ�g�+�
��u�xu��$X��y�	�@/�r��k��e��(��F-������Sa
�z?�䰵iZ��-��C�:G��쵓�Qq��c@�A��;����j�c�|���&�;f% )k�r���"�aE�mJB.�I}�sA�	"l[0�1>ο��g�c.mi
I��5�U5���	a:��߅I��ۅ.�e� ՁR��#&>[�M��>�,�l��-<b��q]w�(�,�L�E7�9���!��oQ@��Ѳ�P�rv6�w�"���.�r�K����AX�g�v���G0l����x�����`'Gu;+�nBs�v�cs�s�g& ��fbsiG L  :��A�X�����	2�Y|�p��d��w�FO���~�<�P����uܰ�>���t����eЈ�d��_o��X���/��دf���BFVoآ59�-a�[�B�(z���)tC�-�y۾y�6�Z(�C�=������z���n��{��%܏�PE/�`r��SE?������;8Ow��ۡY��$��i.٣K�u��p��෌��Z�fOٝ	 D07�����K�7�Î�5L����s��3�>�c�D�[��t�)*����4���(�����h�x�8"�f+d��z�Sh�D���<�h�|�������@|<�[[��w���ݞ�e���PX��+��L�������7�s]��܆�pD@���i㝞	|ղ�=��Y�8���yC�Kv���������C�4��W��$��6����������`�� ����Ni9�Mu[��#F�f�@Y��@���X�v� �d���mZg݀bɺ�ϙwP�w�q|��k��#y�F�6������<2��ZTۤ�f�Պ#��ؙm�����O:��U=�j�?^Gpa1QE��ZA����Y�-T�.0.��y��e+�<�D��`�B4��QG�E�HtZ����\^*�;)Pk1���.�d����>�9���?�j͞u'��e����ۼ���`�&����R�=���"�Ϯ���,N��b��0������h;N�s�����־A��	NS�TtY���ߤ;^���u�����>�E��XkY��L����N��6x9Ljs7�!c�X���c6��X�T�j��oY�8�w�yWPz�X�n�O���X�,b�F���#��A9L�:�;q��8�;��E]����O�`�-��TT�[�x���c��wG�5���&�tϻqԧ3qZ�1�%>����g|�)��"'�����3����6�@�)��*!6Ě�|G�YA��,��[������&�@�˙o�s:�MD�N�PO�x�x�����w����3��k�����>}L�U�cϸC�o��^�s0� �`!_��J��,�N��β�����$�|��9j3x�¦�����\[�H��O��Yx��S~�5�~�
ӏ ����œ��>�qnڙ9O�X#;�JX�1d�����u�v�=Έ0�c?_��(�cA@����a_��u(D�<>�#)�����x'h�X��`y�%��S�i_w:����BY�J	UrL��!<���	7�Iϸ�  �Η���`�*?Ϟ�ԭ�Ͷ/i{n!���9�
�&�̿���a^�ڬd�d@W����G���oCv�f��m���
 i��/vkN�Zx�8�zup���C��)�6|�aL_��Jm?�L��q��Rk-KX�o ����!N�7$eU��;Tx�G9�m�v�:���6��8�
&oY���'o����F,���<�nb��̉2�m��W���k����c�M����ˮ8�;��#M���m�0#eQB�x�[�p�����\l\D�H���[v�K��C������#a�͌�9�����`
�B�q�_1��8ʛ��[�?n��G�Ǻ��!/Vk>�Ӱ��8���7T�!�y��V�=8셿�{�Bx��M<!�.kC��p��~+�u�wz	��"b��p���s9gz��;�V�p�=�����R��i+��t�tr���m|t$�J�cqT ;�1(NԽM�V`��= �r��u�{\R�bX��=͓�x>l��&�RL�?�4Ł:M㳘[OT���xl���n�}��G6�Y��H��ip���f'<�{�VsA�oZ{��ū�pğ���&�,����55����'ö�s���^^��wPɣZ���%$��'���3�a��n�!�Y��x 	�_��wX���1����,g�Q��˽'K����7�����_ı��:�i�f�ѕ=�Ij��J�=<�V�v�W-�m�Um�W���p��;�{=��.^�H����Ʊ<w�5<V�;���%�Ʒ�Vw<:�w�����
�Z�~XQ�VU`�4,Q1��ۘ΁J��X@�������'�8��|~Mkt���]502�:
w�Iq=��|)y�0l�Y��E��+p7�Rqt�q�@�MN�f%�f��,y�Ӭ�H�29]�S��_�spl�s������Jݎ��L"3Ֆ��bt��ܴD��B����:�hD1-�-���q�z��d��:��8a��-��;7ɣ����v����}o*_��o�T��wd�*���P~
�x;����r��x{�<�X��XA朏{���Ap"<-D���{dMހf#^xzt�~A����[#��c��~ۍMx��86a�44S�Q�xSg�����ט͛���T��YE�@N��l�8�s,"���a�F."�ֹ` "��vX�P=i�M�r�	< �s;��c��-)�O�ǟ�B��<ҧ���?X�ϙ�(:|�"�f݅ܮ51w�t�a]��G�ؘ�jL����y�N{T��O�B��A��WGcs���鿳�l/���T�7;;�C�~@��yf�S� ��)����b�VZ΂Dx���^�똎�
���pcx�(O�ٙ���� WC����kMO'������7��o��5ˆ�uv�M!@M k5�f�	^8�x;�����;�_�o��I4���Y�!����"1�[��9�pg"ǡ�X�3��a�Va����s=��@��u�S8~uy�6��3���I�AX�sFu�X���y��Zyܐ+'��ew�M�z��-;��?��H3�1�%��4z�˼��!���=�#���<���ĎF� 1C� �c��������yIy�-N���#;��ېrLۘ��`6g��s�<aR�d��1�?Ҭ޺Y�kqPOwܽT`G�u�	3�㱭Ȳh=�?�>޾g a�%o+!`�p�~��fvBz���t�.w��=U1���c�.;>�q��qkσ;ԗ��=��I�m�癋7����2pM�V77
���:�9
d�-���
$��X�.ǿ���3����D�D{�-|�p
n��i]�=��t&W��`8����=��!qf��}*�z��Y��)�,��@�jm�.�NZ���?��tƯ�k���� ���1t���x�FG��9Yc�������q��U|�Y�{F1�d�@q�C2X� �mߎ��}��yپ 8�ҡΎi�m�0Ψ��Ʀ>F���Y�ek�����@���U���z#�˸�&j�-��ư�p9�*��~�'dϩL���`��I��p�_�lS�y�`�1j�@L��GpxG�9G�z��c�?+�[x̅N��؛a="����v�;��#we7�0MCw<*�0�i�s
�c��g�F�u=)"Y�ڌ?;�
Wf�e�F��n1@�PGB��c�b��9�3vo��fe��֟Otl�������$Ej�n;Xt$䵏���z|���	�5X��Vy�E�+�8�����cc�#L[�nj�(�h������Nxt�""]m"��e�(�l�s�S@mÚ �qCa=3�,^s>��C�ߪ��G\ۗ�T��5_/�O:�Cn�
�X�k}�#�J�6vXh6{��uN����Q��}�8��x��@�Y��@~�1�b��} O�ﯙ}�ﻧ,����0,&����[KZ��c�dډ 0b��6���l��É�/<q�ކ+ī��Ψ7��y<����;Y��}�Y>�����ؒぞ��4oj]5/�a�n�|R������/v���m\�o:;��~�_�:���-�j�*����a��\դ?.��{!�{�ޅGu��n��:�dr�{�wr�ɯ�0��E��6��8�=Հ��uSA�k�{�d��}�ֱ���묯Ng�`��[���T�Gp!V���_��׿��U      �      x������ � �      �      x������ � �     