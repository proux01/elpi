let declaration = ref []

module String = struct
  include String
  let pp fmt s = Format.fprintf fmt "%s" s
  let show = Format.asprintf "%a" pp
end

let pp_tctx _ _ = ()
type tctx = TEntry of (string[@elpi.key]) * bool
[@@elpi.index (module String)]
[@@deriving_inline elpi { declaration }]
let _ = fun (_ : tctx) -> ()
[@@@warning "-26-27-32-39-60"]
let elpi_constant_type_tctx = "tctx"
let _ = elpi_constant_type_tctx
let elpi_constant_type_tctxc =
  Elpi.API.RawData.Constants.declare_global_symbol elpi_constant_type_tctx
let _ = elpi_constant_type_tctxc
let elpi_constant_constructor_tctx_TEntry = "tentry"
let _ = elpi_constant_constructor_tctx_TEntry
let elpi_constant_constructor_tctx_TEntryc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_tctx_TEntry
let _ = elpi_constant_constructor_tctx_TEntryc
module Elpi_tctx_Map = (Elpi.API.Utils.Map.Make)(String)
let elpi_tctx_state =
  Elpi.API.State.declare ~name:"tctx"
    ~pp:(fun fmt -> fun _ -> Format.fprintf fmt "TODO")
    ~init:(fun () ->
             ((Elpi_tctx_Map.empty : Elpi.API.RawData.constant
                                       Elpi_tctx_Map.t),
               (Elpi.API.RawData.Constants.Map.empty : tctx
                                                         Elpi.API.Conversion.ctx_entry
                                                         Elpi.API.RawData.Constants.Map.t)))
let _ = elpi_tctx_state
let elpi_tctx_to_key ~depth:_  = function | TEntry (elpi__16, _) -> elpi__16
let _ = elpi_tctx_to_key
let elpi_is_tctx { Elpi.API.Data.hdepth = elpi__depth; hsrc = elpi__x } =
  match Elpi.API.RawData.look ~depth:elpi__depth elpi__x with
  | Elpi.API.RawData.Const _ -> None
  | Elpi.API.RawData.App (elpi__hd, elpi__idx, _) ->
      if false || (elpi__hd == elpi_constant_constructor_tctx_TEntryc)
      then
        (match Elpi.API.RawData.look ~depth:elpi__depth elpi__idx with
         | Elpi.API.RawData.Const x -> Some x
         | _ ->
             Elpi.API.Utils.type_error
               "context entry applied to a non nominal")
      else None
  | _ -> None
let _ = elpi_is_tctx
let elpi_push_tctx ~depth:elpi__depth  elpi__state elpi__name elpi__ctx_item
  =
  let (elpi__ctx2dbl, elpi__dbl2ctx) =
    Elpi.API.State.get elpi_tctx_state elpi__state in
  let elpi__i = elpi__depth in
  let elpi__ctx2dbl = Elpi_tctx_Map.add elpi__name elpi__i elpi__ctx2dbl in
  let elpi__dbl2ctx =
    Elpi.API.RawData.Constants.Map.add elpi__i elpi__ctx_item elpi__dbl2ctx in
  let elpi__state =
    Elpi.API.State.set elpi_tctx_state elpi__state
      (elpi__ctx2dbl, elpi__dbl2ctx) in
  elpi__state
let _ = elpi_push_tctx
let elpi_pop_tctx ~depth:elpi__depth  elpi__state elpi__name =
  let (elpi__ctx2dbl, elpi__dbl2ctx) =
    Elpi.API.State.get elpi_tctx_state elpi__state in
  let elpi__i = elpi__depth in
  let elpi__ctx2dbl = Elpi_tctx_Map.remove elpi__name elpi__ctx2dbl in
  let elpi__dbl2ctx =
    Elpi.API.RawData.Constants.Map.remove elpi__i elpi__dbl2ctx in
  let elpi__state =
    Elpi.API.State.set elpi_tctx_state elpi__state
      (elpi__ctx2dbl, elpi__dbl2ctx) in
  elpi__state
let _ = elpi_pop_tctx
let rec elpi_embed_tctx :
  'c .
    ((Elpi.API.RawData.constant * tctx), #Elpi.API.Conversion.ctx as 'c)
      Elpi.API.Conversion.embedding
  =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          function
          | (elpi__9, TEntry (elpi__7, elpi__8)) ->
              let (elpi__state, elpi__13, elpi__10) =
                Elpi.API.BuiltInData.nominal.Elpi.API.Conversion.embed
                  ~depth:elpi__depth elpi__hyps elpi__constraints elpi__state
                  elpi__9 in
              let (elpi__state, elpi__14, elpi__11) =
                Elpi.API.PPX.embed_string ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__7 in
              let (elpi__state, elpi__15, elpi__12) =
                Elpi.Builtin.PPX.embed_bool ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__8 in
              (elpi__state,
                (Elpi.API.RawData.mkAppL
                   elpi_constant_constructor_tctx_TEntryc
                   [elpi__13; elpi__14; elpi__15]),
                (List.concat [elpi__10; elpi__11; elpi__12]))
let _ = elpi_embed_tctx
let rec elpi_readback_tctx :
  'c .
    ((Elpi.API.RawData.constant * tctx), #Elpi.API.Conversion.ctx as 'c)
      Elpi.API.Conversion.readback
  =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          fun elpi__x ->
            match Elpi.API.RawData.look ~depth:elpi__depth elpi__x with
            | Elpi.API.RawData.App (elpi__hd, elpi__x, elpi__xs) when
                elpi__hd == elpi_constant_constructor_tctx_TEntryc ->
                let (elpi__state, elpi__6, elpi__5) =
                  Elpi.API.BuiltInData.nominal.Elpi.API.Conversion.readback
                    ~depth:elpi__depth elpi__hyps elpi__constraints
                    elpi__state elpi__x in
                (match elpi__xs with
                 | elpi__1::elpi__2::[] ->
                     let (elpi__state, elpi__1, elpi__3) =
                       Elpi.API.PPX.readback_string ~depth:elpi__depth
                         elpi__hyps elpi__constraints elpi__state elpi__1 in
                     let (elpi__state, elpi__2, elpi__4) =
                       Elpi.Builtin.PPX.readback_bool ~depth:elpi__depth
                         elpi__hyps elpi__constraints elpi__state elpi__2 in
                     (elpi__state, (elpi__6, (TEntry (elpi__1, elpi__2))),
                       (List.concat [elpi__5; elpi__3; elpi__4]))
                 | _ ->
                     Elpi.API.Utils.type_error
                       ("Not enough arguments to constructor: " ^
                          (Elpi.API.RawData.Constants.show
                             elpi_constant_constructor_tctx_TEntryc)))
            | _ ->
                Elpi.API.Utils.type_error
                  (Format.asprintf "Not a constructor of type %s: %a" "tctx"
                     (Elpi.API.RawPp.term elpi__depth) elpi__x)
let _ = elpi_readback_tctx
let tctx :
  'c .
    ((Elpi.API.RawData.constant * tctx), #Elpi.API.Conversion.ctx as 'c)
      Elpi.API.Conversion.t
  =
  let kind = Elpi.API.Conversion.TyName "tctx" in
  {
    Elpi.API.Conversion.ty = kind;
    pp_doc =
      (fun fmt ->
         fun () ->
           Elpi.API.PPX.Doc.kind fmt kind ~doc:"tctx";
           Elpi.API.PPX.Doc.constructor fmt
             ~ty:(Elpi.API.Conversion.TyName "prop") ~name:"tentry"
             ~doc:"TEntry"
             ~args:[Elpi.API.BuiltInData.nominal.Elpi.API.Conversion.ty;
                   Elpi.API.BuiltInData.string.Elpi.API.Conversion.ty;
                   Elpi.Builtin.bool.Elpi.API.Conversion.ty]);
    pp = (fun fmt -> fun (_, x) -> pp_tctx fmt x);
    embed = elpi_embed_tctx;
    readback = elpi_readback_tctx
  }
let _ = tctx
let in_tctx =
  {
    Elpi.API.Conversion.is_entry_for_nominal = elpi_is_tctx;
    to_key = elpi_tctx_to_key;
    push = elpi_push_tctx;
    pop = elpi_pop_tctx;
    conv = tctx;
    init =
      (fun state ->
         Elpi.API.State.set elpi_tctx_state state
           ((Elpi_tctx_Map.empty : Elpi.API.RawData.constant Elpi_tctx_Map.t),
             (Elpi.API.RawData.Constants.Map.empty : tctx
                                                       Elpi.API.Conversion.ctx_entry
                                                       Elpi.API.RawData.Constants.Map.t)));
    get = (fun state -> snd @@ (Elpi.API.State.get elpi_tctx_state state))
  }
let _ = in_tctx
let elpi_tctx = Elpi.API.BuiltIn.MLData tctx
let _ = elpi_tctx
let () = declaration := ((!declaration) @ [elpi_tctx])
[@@@end]

let pp_ty _ _ = ()
type ty =
  | TVar of string [@elpi.var tctx]
  | TApp of string * ty
  | TAll of bool * string * (ty[@elpi.binder tctx (fun b s -> TEntry(s,b))])
[@@deriving_inline elpi { declaration; }]
let _ = fun (_ : ty) -> ()
[@@@warning "-26-27-32-39-60"]
let elpi_constant_type_ty = "ty"
let _ = elpi_constant_type_ty
let elpi_constant_type_tyc =
  Elpi.API.RawData.Constants.declare_global_symbol elpi_constant_type_ty
let _ = elpi_constant_type_tyc
let elpi_constant_constructor_ty_TVar = "tvar"
let _ = elpi_constant_constructor_ty_TVar
let elpi_constant_constructor_ty_TVarc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_ty_TVar
let _ = elpi_constant_constructor_ty_TVarc
let elpi_constant_constructor_ty_TApp = "tapp"
let _ = elpi_constant_constructor_ty_TApp
let elpi_constant_constructor_ty_TAppc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_ty_TApp
let _ = elpi_constant_constructor_ty_TAppc
let elpi_constant_constructor_ty_TAll = "tall"
let _ = elpi_constant_constructor_ty_TAll
let elpi_constant_constructor_ty_TAllc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_ty_TAll
let _ = elpi_constant_constructor_ty_TAllc
class type ty_ctx =
  object
    inherit Elpi.API.Conversion.ctx
    method  tctx : tctx Elpi.API.Conversion.ctx_field
  end
let rec elpi_embed_ty :
  'c . (ty, #ty_ctx as 'c) Elpi.API.Conversion.embedding =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          function
          | TVar elpi__29 ->
              let (elpi__ctx2dbl, _) =
                Elpi.API.State.get elpi_tctx_state elpi__state in
              let elpi__key = (fun x -> x) elpi__29 in
              (if not (Elpi_tctx_Map.mem elpi__key elpi__ctx2dbl)
               then Elpi.API.Utils.error "Unbound variable";
               (elpi__state,
                 (Elpi.API.RawData.mkBound
                    (Elpi_tctx_Map.find elpi__key elpi__ctx2dbl)), []))
          | TApp (elpi__32, elpi__33) ->
              let (elpi__state, elpi__36, elpi__34) =
                Elpi.API.PPX.embed_string ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__32 in
              let (elpi__state, elpi__37, elpi__35) =
                elpi_embed_ty ~depth:elpi__depth elpi__hyps elpi__constraints
                  elpi__state elpi__33 in
              (elpi__state,
                (Elpi.API.RawData.mkAppL elpi_constant_constructor_ty_TAppc
                   [elpi__36; elpi__37]), (List.concat [elpi__34; elpi__35]))
          | TAll (elpi__38, elpi__39, elpi__40) ->
              let (elpi__state, elpi__44, elpi__41) =
                Elpi.Builtin.PPX.embed_bool ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__38 in
              let (elpi__state, elpi__45, elpi__42) =
                Elpi.API.PPX.embed_string ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__39 in
              let elpi__ctx_entry =
                (fun b -> fun s -> TEntry (s, b)) elpi__38 elpi__39 in
              let elpi__ctx_key =
                elpi_tctx_to_key ~depth:elpi__depth elpi__ctx_entry in
              let elpi__ctx_entry =
                {
                  Elpi.API.Conversion.entry = elpi__ctx_entry;
                  depth = elpi__depth
                } in
              let elpi__state =
                elpi_push_tctx ~depth:(elpi__depth + 1) elpi__state
                  elpi__ctx_key elpi__ctx_entry in
              let (elpi__state, elpi__47, elpi__43) =
                elpi_embed_ty ~depth:(elpi__depth + 1) elpi__hyps
                  elpi__constraints elpi__state elpi__40 in
              let elpi__46 = Elpi.API.RawData.mkLam elpi__47 in
              let elpi__state =
                elpi_pop_tctx ~depth:(elpi__depth + 1) elpi__state
                  elpi__ctx_key in
              (elpi__state,
                (Elpi.API.RawData.mkAppL elpi_constant_constructor_ty_TAllc
                   [elpi__44; elpi__45; elpi__46]),
                (List.concat [elpi__41; elpi__42; elpi__43]))
let _ = elpi_embed_ty
let rec elpi_readback_ty :
  'c . (ty, #ty_ctx as 'c) Elpi.API.Conversion.readback =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          fun elpi__x ->
            match Elpi.API.RawData.look ~depth:elpi__depth elpi__x with
            | Elpi.API.RawData.Const elpi__hd when elpi__hd >= 0 ->
                let (_, elpi__dbl2ctx) =
                  Elpi.API.State.get elpi_tctx_state elpi__state in
                (if
                   not
                     (Elpi.API.RawData.Constants.Map.mem elpi__hd
                        elpi__dbl2ctx)
                 then
                   Elpi.API.Utils.error
                     (Format.asprintf "Unbound variable: %s in %a"
                        (Elpi.API.RawData.Constants.show elpi__hd)
                        (Elpi.API.RawData.Constants.Map.pp
                           (Elpi.API.Conversion.pp_ctx_entry pp_tctx))
                        elpi__dbl2ctx);
                 (let { Elpi.API.Conversion.entry = elpi__entry;
                        depth = elpi__depth }
                    =
                    Elpi.API.RawData.Constants.Map.find elpi__hd
                      elpi__dbl2ctx in
                  (elpi__state,
                    (TVar (elpi_tctx_to_key ~depth:elpi__depth elpi__entry)),
                    [])))
            | Elpi.API.RawData.App (elpi__hd, elpi__x, elpi__xs) when
                elpi__hd == elpi_constant_constructor_ty_TAppc ->
                let (elpi__state, elpi__22, elpi__21) =
                  Elpi.API.PPX.readback_string ~depth:elpi__depth elpi__hyps
                    elpi__constraints elpi__state elpi__x in
                (match elpi__xs with
                 | elpi__19::[] ->
                     let (elpi__state, elpi__19, elpi__20) =
                       elpi_readback_ty ~depth:elpi__depth elpi__hyps
                         elpi__constraints elpi__state elpi__19 in
                     (elpi__state, (TApp (elpi__22, elpi__19)),
                       (List.concat [elpi__21; elpi__20]))
                 | _ ->
                     Elpi.API.Utils.type_error
                       ("Not enough arguments to constructor: " ^
                          (Elpi.API.RawData.Constants.show
                             elpi_constant_constructor_ty_TAppc)))
            | Elpi.API.RawData.App (elpi__hd, elpi__x, elpi__xs) when
                elpi__hd == elpi_constant_constructor_ty_TAllc ->
                let (elpi__state, elpi__28, elpi__27) =
                  Elpi.Builtin.PPX.readback_bool ~depth:elpi__depth
                    elpi__hyps elpi__constraints elpi__state elpi__x in
                (match elpi__xs with
                 | elpi__23::elpi__24::[] ->
                     let (elpi__state, elpi__23, elpi__25) =
                       Elpi.API.PPX.readback_string ~depth:elpi__depth
                         elpi__hyps elpi__constraints elpi__state elpi__23 in
                     let elpi__ctx_entry =
                       (fun b -> fun s -> TEntry (s, b)) elpi__28 elpi__23 in
                     let elpi__ctx_key =
                       elpi_tctx_to_key ~depth:elpi__depth elpi__ctx_entry in
                     let elpi__ctx_entry =
                       {
                         Elpi.API.Conversion.entry = elpi__ctx_entry;
                         depth = elpi__depth
                       } in
                     let elpi__state =
                       elpi_push_tctx ~depth:elpi__depth elpi__state
                         elpi__ctx_key elpi__ctx_entry in
                     let (elpi__state, elpi__24, elpi__26) =
                       match Elpi.API.RawData.look ~depth:elpi__depth
                               elpi__24
                       with
                       | Elpi.API.RawData.Lam elpi__bo ->
                           elpi_readback_ty ~depth:(elpi__depth + 1)
                             elpi__hyps elpi__constraints elpi__state
                             elpi__bo
                       | _ -> assert false in
                     let elpi__state =
                       elpi_pop_tctx ~depth:elpi__depth elpi__state
                         elpi__ctx_key in
                     (elpi__state, (TAll (elpi__28, elpi__23, elpi__24)),
                       (List.concat [elpi__27; elpi__25; elpi__26]))
                 | _ ->
                     Elpi.API.Utils.type_error
                       ("Not enough arguments to constructor: " ^
                          (Elpi.API.RawData.Constants.show
                             elpi_constant_constructor_ty_TAllc)))
            | _ ->
                Elpi.API.Utils.type_error
                  (Format.asprintf "Not a constructor of type %s: %a" "ty"
                     (Elpi.API.RawPp.term elpi__depth) elpi__x)
let _ = elpi_readback_ty
let ty : 'c . (ty, #ty_ctx as 'c) Elpi.API.Conversion.t =
  let kind = Elpi.API.Conversion.TyName "ty" in
  {
    Elpi.API.Conversion.ty = kind;
    pp_doc =
      (fun fmt ->
         fun () ->
           Elpi.API.PPX.Doc.kind fmt kind ~doc:"ty";
           Elpi.API.PPX.Doc.constructor fmt ~ty:kind ~name:"tapp" ~doc:"TApp"
             ~args:[Elpi.API.BuiltInData.string.Elpi.API.Conversion.ty;
                   Elpi.API.Conversion.TyName elpi_constant_type_ty];
           Elpi.API.PPX.Doc.constructor fmt ~ty:kind ~name:"tall" ~doc:"TAll"
             ~args:[Elpi.Builtin.bool.Elpi.API.Conversion.ty;
                   Elpi.API.BuiltInData.string.Elpi.API.Conversion.ty;
                   Elpi.API.Conversion.TyApp
                     ("->", (Elpi.API.Conversion.TyName "ty"),
                       [Elpi.API.Conversion.TyName elpi_constant_type_ty])]);
    pp = pp_ty;
    embed = elpi_embed_ty;
    readback = elpi_readback_ty
  }
let _ = ty
let elpi_ty = Elpi.API.BuiltIn.MLData ty
let _ = elpi_ty
let (ty_ctx : Elpi.API.Data.hyps -> Elpi.API.State.t -> ty_ctx) =
  fun h ->
    fun s ->
      object (_)
        inherit  ((Elpi.API.Conversion.ctx) h)
        method tctx = in_tctx.Elpi.API.Conversion.get s
      end
let _ = ty_ctx
let in_ty_ctx ~depth  h c s =
  let ctl = [Elpi.API.PPX.C in_tctx] in
  let (s, gls) = Elpi.API.PPX.readback_context ~depth ctl h c s in
  (s, (ty_ctx h s), gls)
let _ = in_ty_ctx
let () = declaration := ((!declaration) @ [elpi_ty])
[@@@end]


let pp_ctx _ _ = ()
type ctx = Entry of (string[@elpi.key]) * ty
[@@elpi.index (module String)]
[@@deriving_inline elpi { declaration ; context = [tctx]} ]
let _ = fun (_ : ctx) -> ()
[@@@warning "-26-27-32-39-60"]
let elpi_constant_type_ctx = "ctx"
let _ = elpi_constant_type_ctx
let elpi_constant_type_ctxc =
  Elpi.API.RawData.Constants.declare_global_symbol elpi_constant_type_ctx
let _ = elpi_constant_type_ctxc
let elpi_constant_constructor_ctx_Entry = "entry"
let _ = elpi_constant_constructor_ctx_Entry
let elpi_constant_constructor_ctx_Entryc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_ctx_Entry
let _ = elpi_constant_constructor_ctx_Entryc
module Elpi_ctx_Map = (Elpi.API.Utils.Map.Make)(String)
let elpi_ctx_state =
  Elpi.API.State.declare ~name:"ctx"
    ~pp:(fun fmt -> fun _ -> Format.fprintf fmt "TODO")
    ~init:(fun () ->
             ((Elpi_ctx_Map.empty : Elpi.API.RawData.constant Elpi_ctx_Map.t),
               (Elpi.API.RawData.Constants.Map.empty : ctx
                                                         Elpi.API.Conversion.ctx_entry
                                                         Elpi.API.RawData.Constants.Map.t)))
let _ = elpi_ctx_state
let elpi_ctx_to_key ~depth:_  = function | Entry (elpi__63, _) -> elpi__63
let _ = elpi_ctx_to_key
let elpi_is_ctx { Elpi.API.Data.hdepth = elpi__depth; hsrc = elpi__x } =
  match Elpi.API.RawData.look ~depth:elpi__depth elpi__x with
  | Elpi.API.RawData.Const _ -> None
  | Elpi.API.RawData.App (elpi__hd, elpi__idx, _) ->
      if false || (elpi__hd == elpi_constant_constructor_ctx_Entryc)
      then
        (match Elpi.API.RawData.look ~depth:elpi__depth elpi__idx with
         | Elpi.API.RawData.Const x -> Some x
         | _ ->
             Elpi.API.Utils.type_error
               "context entry applied to a non nominal")
      else None
  | _ -> None
let _ = elpi_is_ctx
let elpi_push_ctx ~depth:elpi__depth  elpi__state elpi__name elpi__ctx_item =
  let (elpi__ctx2dbl, elpi__dbl2ctx) =
    Elpi.API.State.get elpi_ctx_state elpi__state in
  let elpi__i = elpi__depth in
  let elpi__ctx2dbl = Elpi_ctx_Map.add elpi__name elpi__i elpi__ctx2dbl in
  let elpi__dbl2ctx =
    Elpi.API.RawData.Constants.Map.add elpi__i elpi__ctx_item elpi__dbl2ctx in
  let elpi__state =
    Elpi.API.State.set elpi_ctx_state elpi__state
      (elpi__ctx2dbl, elpi__dbl2ctx) in
  elpi__state
let _ = elpi_push_ctx
let elpi_pop_ctx ~depth:elpi__depth  elpi__state elpi__name =
  let (elpi__ctx2dbl, elpi__dbl2ctx) =
    Elpi.API.State.get elpi_ctx_state elpi__state in
  let elpi__i = elpi__depth in
  let elpi__ctx2dbl = Elpi_ctx_Map.remove elpi__name elpi__ctx2dbl in
  let elpi__dbl2ctx =
    Elpi.API.RawData.Constants.Map.remove elpi__i elpi__dbl2ctx in
  let elpi__state =
    Elpi.API.State.set elpi_ctx_state elpi__state
      (elpi__ctx2dbl, elpi__dbl2ctx) in
  elpi__state
let _ = elpi_pop_ctx
class type ctx_ctx =
  object
    inherit Elpi.API.Conversion.ctx
    method  tctx : tctx Elpi.API.Conversion.ctx_field
  end
let rec elpi_embed_ctx :
  'c .
    ((Elpi.API.RawData.constant * ctx), #ctx_ctx as 'c)
      Elpi.API.Conversion.embedding
  =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          function
          | (elpi__56, Entry (elpi__54, elpi__55)) ->
              let (elpi__state, elpi__60, elpi__57) =
                Elpi.API.BuiltInData.nominal.Elpi.API.Conversion.embed
                  ~depth:elpi__depth elpi__hyps elpi__constraints elpi__state
                  elpi__56 in
              let (elpi__state, elpi__61, elpi__58) =
                Elpi.API.PPX.embed_string ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__54 in
              let (elpi__state, elpi__62, elpi__59) =
                ty.Elpi.API.Conversion.embed ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__55 in
              (elpi__state,
                (Elpi.API.RawData.mkAppL elpi_constant_constructor_ctx_Entryc
                   [elpi__60; elpi__61; elpi__62]),
                (List.concat [elpi__57; elpi__58; elpi__59]))
let _ = elpi_embed_ctx
let rec elpi_readback_ctx :
  'c .
    ((Elpi.API.RawData.constant * ctx), #ctx_ctx as 'c)
      Elpi.API.Conversion.readback
  =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          fun elpi__x ->
            match Elpi.API.RawData.look ~depth:elpi__depth elpi__x with
            | Elpi.API.RawData.App (elpi__hd, elpi__x, elpi__xs) when
                elpi__hd == elpi_constant_constructor_ctx_Entryc ->
                let (elpi__state, elpi__53, elpi__52) =
                  Elpi.API.BuiltInData.nominal.Elpi.API.Conversion.readback
                    ~depth:elpi__depth elpi__hyps elpi__constraints
                    elpi__state elpi__x in
                (match elpi__xs with
                 | elpi__48::elpi__49::[] ->
                     let (elpi__state, elpi__48, elpi__50) =
                       Elpi.API.PPX.readback_string ~depth:elpi__depth
                         elpi__hyps elpi__constraints elpi__state elpi__48 in
                     let (elpi__state, elpi__49, elpi__51) =
                       ty.Elpi.API.Conversion.readback ~depth:elpi__depth
                         elpi__hyps elpi__constraints elpi__state elpi__49 in
                     (elpi__state, (elpi__53, (Entry (elpi__48, elpi__49))),
                       (List.concat [elpi__52; elpi__50; elpi__51]))
                 | _ ->
                     Elpi.API.Utils.type_error
                       ("Not enough arguments to constructor: " ^
                          (Elpi.API.RawData.Constants.show
                             elpi_constant_constructor_ctx_Entryc)))
            | _ ->
                Elpi.API.Utils.type_error
                  (Format.asprintf "Not a constructor of type %s: %a" "ctx"
                     (Elpi.API.RawPp.term elpi__depth) elpi__x)
let _ = elpi_readback_ctx
let ctx :
  'c .
    ((Elpi.API.RawData.constant * ctx), #ctx_ctx as 'c) Elpi.API.Conversion.t
  =
  let kind = Elpi.API.Conversion.TyName "ctx" in
  {
    Elpi.API.Conversion.ty = kind;
    pp_doc =
      (fun fmt ->
         fun () ->
           Elpi.API.PPX.Doc.kind fmt kind ~doc:"ctx";
           Elpi.API.PPX.Doc.constructor fmt
             ~ty:(Elpi.API.Conversion.TyName "prop") ~name:"entry"
             ~doc:"Entry"
             ~args:[Elpi.API.BuiltInData.nominal.Elpi.API.Conversion.ty;
                   Elpi.API.BuiltInData.string.Elpi.API.Conversion.ty;
                   ty.Elpi.API.Conversion.ty]);
    pp = (fun fmt -> fun (_, x) -> pp_ctx fmt x);
    embed = elpi_embed_ctx;
    readback = elpi_readback_ctx
  }
let _ = ctx
let in_ctx =
  {
    Elpi.API.Conversion.is_entry_for_nominal = elpi_is_ctx;
    to_key = elpi_ctx_to_key;
    push = elpi_push_ctx;
    pop = elpi_pop_ctx;
    conv = ctx;
    init =
      (fun state ->
         Elpi.API.State.set elpi_ctx_state state
           ((Elpi_ctx_Map.empty : Elpi.API.RawData.constant Elpi_ctx_Map.t),
             (Elpi.API.RawData.Constants.Map.empty : ctx
                                                       Elpi.API.Conversion.ctx_entry
                                                       Elpi.API.RawData.Constants.Map.t)));
    get = (fun state -> snd @@ (Elpi.API.State.get elpi_ctx_state state))
  }
let _ = in_ctx
let elpi_ctx = Elpi.API.BuiltIn.MLData ctx
let _ = elpi_ctx
let (ctx_ctx : Elpi.API.Data.hyps -> Elpi.API.State.t -> ctx_ctx) =
  fun h ->
    fun s ->
      object (_)
        inherit  ((Elpi.API.Conversion.ctx) h)
        method tctx = in_tctx.Elpi.API.Conversion.get s
      end
let _ = ctx_ctx
let in_ctx_ctx ~depth  h c s =
  let ctl = [Elpi.API.PPX.C in_tctx] in
  let (s, gls) = Elpi.API.PPX.readback_context ~depth ctl h c s in
  (s, (ctx_ctx h s), gls)
let _ = in_ctx_ctx
let () = declaration := ((!declaration) @ [elpi_ctx])
[@@@end]

let pp_term _ _ = ()
type term =
  | Var of string [@elpi.var ctx]
  | App of term * term
  | Lam of ty * string * (term[@elpi.binder ctx (fun b s -> Entry(s,b))])
[@@deriving_inline elpi { declaration; context = [ctx;tctx] }]
let _ = fun (_ : term) -> ()
[@@@warning "-26-27-32-39-60"]
let elpi_constant_type_term = "term"
let _ = elpi_constant_type_term
let elpi_constant_type_termc =
  Elpi.API.RawData.Constants.declare_global_symbol elpi_constant_type_term
let _ = elpi_constant_type_termc
let elpi_constant_constructor_term_Var = "var"
let _ = elpi_constant_constructor_term_Var
let elpi_constant_constructor_term_Varc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_term_Var
let _ = elpi_constant_constructor_term_Varc
let elpi_constant_constructor_term_App = "app"
let _ = elpi_constant_constructor_term_App
let elpi_constant_constructor_term_Appc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_term_App
let _ = elpi_constant_constructor_term_Appc
let elpi_constant_constructor_term_Lam = "lam"
let _ = elpi_constant_constructor_term_Lam
let elpi_constant_constructor_term_Lamc =
  Elpi.API.RawData.Constants.declare_global_symbol
    elpi_constant_constructor_term_Lam
let _ = elpi_constant_constructor_term_Lamc
class type term_ctx =
  object
    inherit Elpi.API.Conversion.ctx
    method  ctx : ctx Elpi.API.Conversion.ctx_field
    method  tctx : tctx Elpi.API.Conversion.ctx_field
  end
let rec elpi_embed_term :
  'c . (term, #term_ctx as 'c) Elpi.API.Conversion.embedding =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          function
          | Var elpi__76 ->
              let (elpi__ctx2dbl, _) =
                Elpi.API.State.get elpi_ctx_state elpi__state in
              let elpi__key = (fun x -> x) elpi__76 in
              (if not (Elpi_ctx_Map.mem elpi__key elpi__ctx2dbl)
               then Elpi.API.Utils.error "Unbound variable";
               (elpi__state,
                 (Elpi.API.RawData.mkBound
                    (Elpi_ctx_Map.find elpi__key elpi__ctx2dbl)), []))
          | App (elpi__79, elpi__80) ->
              let (elpi__state, elpi__83, elpi__81) =
                elpi_embed_term ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__79 in
              let (elpi__state, elpi__84, elpi__82) =
                elpi_embed_term ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__80 in
              (elpi__state,
                (Elpi.API.RawData.mkAppL elpi_constant_constructor_term_Appc
                   [elpi__83; elpi__84]), (List.concat [elpi__81; elpi__82]))
          | Lam (elpi__85, elpi__86, elpi__87) ->
              let (elpi__state, elpi__91, elpi__88) =
                ty.Elpi.API.Conversion.embed ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__85 in
              let (elpi__state, elpi__92, elpi__89) =
                Elpi.API.PPX.embed_string ~depth:elpi__depth elpi__hyps
                  elpi__constraints elpi__state elpi__86 in
              let elpi__ctx_entry =
                (fun b -> fun s -> Entry (s, b)) elpi__85 elpi__86 in
              let elpi__ctx_key =
                elpi_ctx_to_key ~depth:elpi__depth elpi__ctx_entry in
              let elpi__ctx_entry =
                {
                  Elpi.API.Conversion.entry = elpi__ctx_entry;
                  depth = elpi__depth
                } in
              let elpi__state =
                elpi_push_ctx ~depth:(elpi__depth + 1) elpi__state
                  elpi__ctx_key elpi__ctx_entry in
              let (elpi__state, elpi__94, elpi__90) =
                elpi_embed_term ~depth:(elpi__depth + 1) elpi__hyps
                  elpi__constraints elpi__state elpi__87 in
              let elpi__93 = Elpi.API.RawData.mkLam elpi__94 in
              let elpi__state =
                elpi_pop_ctx ~depth:(elpi__depth + 1) elpi__state
                  elpi__ctx_key in
              (elpi__state,
                (Elpi.API.RawData.mkAppL elpi_constant_constructor_term_Lamc
                   [elpi__91; elpi__92; elpi__93]),
                (List.concat [elpi__88; elpi__89; elpi__90]))
let _ = elpi_embed_term
let rec elpi_readback_term :
  'c . (term, #term_ctx as 'c) Elpi.API.Conversion.readback =
  fun ~depth:elpi__depth ->
    fun elpi__hyps ->
      fun elpi__constraints ->
        fun elpi__state ->
          fun elpi__x ->
            match Elpi.API.RawData.look ~depth:elpi__depth elpi__x with
            | Elpi.API.RawData.Const elpi__hd when elpi__hd >= 0 ->
                let (_, elpi__dbl2ctx) =
                  Elpi.API.State.get elpi_ctx_state elpi__state in
                (if
                   not
                     (Elpi.API.RawData.Constants.Map.mem elpi__hd
                        elpi__dbl2ctx)
                 then
                   Elpi.API.Utils.error
                     (Format.asprintf "Unbound variable: %s in %a"
                        (Elpi.API.RawData.Constants.show elpi__hd)
                        (Elpi.API.RawData.Constants.Map.pp
                           (Elpi.API.Conversion.pp_ctx_entry pp_ctx))
                        elpi__dbl2ctx);
                 (let { Elpi.API.Conversion.entry = elpi__entry;
                        depth = elpi__depth }
                    =
                    Elpi.API.RawData.Constants.Map.find elpi__hd
                      elpi__dbl2ctx in
                  (elpi__state,
                    (Var (elpi_ctx_to_key ~depth:elpi__depth elpi__entry)),
                    [])))
            | Elpi.API.RawData.App (elpi__hd, elpi__x, elpi__xs) when
                elpi__hd == elpi_constant_constructor_term_Appc ->
                let (elpi__state, elpi__69, elpi__68) =
                  elpi_readback_term ~depth:elpi__depth elpi__hyps
                    elpi__constraints elpi__state elpi__x in
                (match elpi__xs with
                 | elpi__66::[] ->
                     let (elpi__state, elpi__66, elpi__67) =
                       elpi_readback_term ~depth:elpi__depth elpi__hyps
                         elpi__constraints elpi__state elpi__66 in
                     (elpi__state, (App (elpi__69, elpi__66)),
                       (List.concat [elpi__68; elpi__67]))
                 | _ ->
                     Elpi.API.Utils.type_error
                       ("Not enough arguments to constructor: " ^
                          (Elpi.API.RawData.Constants.show
                             elpi_constant_constructor_term_Appc)))
            | Elpi.API.RawData.App (elpi__hd, elpi__x, elpi__xs) when
                elpi__hd == elpi_constant_constructor_term_Lamc ->
                let (elpi__state, elpi__75, elpi__74) =
                  ty.Elpi.API.Conversion.readback ~depth:elpi__depth
                    elpi__hyps elpi__constraints elpi__state elpi__x in
                (match elpi__xs with
                 | elpi__70::elpi__71::[] ->
                     let (elpi__state, elpi__70, elpi__72) =
                       Elpi.API.PPX.readback_string ~depth:elpi__depth
                         elpi__hyps elpi__constraints elpi__state elpi__70 in
                     let elpi__ctx_entry =
                       (fun b -> fun s -> Entry (s, b)) elpi__75 elpi__70 in
                     let elpi__ctx_key =
                       elpi_ctx_to_key ~depth:elpi__depth elpi__ctx_entry in
                     let elpi__ctx_entry =
                       {
                         Elpi.API.Conversion.entry = elpi__ctx_entry;
                         depth = elpi__depth
                       } in
                     let elpi__state =
                       elpi_push_ctx ~depth:elpi__depth elpi__state
                         elpi__ctx_key elpi__ctx_entry in
                     let (elpi__state, elpi__71, elpi__73) =
                       match Elpi.API.RawData.look ~depth:elpi__depth
                               elpi__71
                       with
                       | Elpi.API.RawData.Lam elpi__bo ->
                           elpi_readback_term ~depth:(elpi__depth + 1)
                             elpi__hyps elpi__constraints elpi__state
                             elpi__bo
                       | _ -> assert false in
                     let elpi__state =
                       elpi_pop_ctx ~depth:elpi__depth elpi__state
                         elpi__ctx_key in
                     (elpi__state, (Lam (elpi__75, elpi__70, elpi__71)),
                       (List.concat [elpi__74; elpi__72; elpi__73]))
                 | _ ->
                     Elpi.API.Utils.type_error
                       ("Not enough arguments to constructor: " ^
                          (Elpi.API.RawData.Constants.show
                             elpi_constant_constructor_term_Lamc)))
            | _ ->
                Elpi.API.Utils.type_error
                  (Format.asprintf "Not a constructor of type %s: %a" "term"
                     (Elpi.API.RawPp.term elpi__depth) elpi__x)
let _ = elpi_readback_term
let term : 'c . (term, #term_ctx as 'c) Elpi.API.Conversion.t =
  let kind = Elpi.API.Conversion.TyName "term" in
  {
    Elpi.API.Conversion.ty = kind;
    pp_doc =
      (fun fmt ->
         fun () ->
           Elpi.API.PPX.Doc.kind fmt kind ~doc:"term";
           Elpi.API.PPX.Doc.constructor fmt ~ty:kind ~name:"app" ~doc:"App"
             ~args:[Elpi.API.Conversion.TyName elpi_constant_type_term;
                   Elpi.API.Conversion.TyName elpi_constant_type_term];
           Elpi.API.PPX.Doc.constructor fmt ~ty:kind ~name:"lam" ~doc:"Lam"
             ~args:[ty.Elpi.API.Conversion.ty;
                   Elpi.API.BuiltInData.string.Elpi.API.Conversion.ty;
                   Elpi.API.Conversion.TyApp
                     ("->", (Elpi.API.Conversion.TyName "term"),
                       [Elpi.API.Conversion.TyName elpi_constant_type_term])]);
    pp = pp_term;
    embed = elpi_embed_term;
    readback = elpi_readback_term
  }
let _ = term
let elpi_term = Elpi.API.BuiltIn.MLData term
let _ = elpi_term
let (term_ctx : Elpi.API.Data.hyps -> Elpi.API.State.t -> term_ctx) =
  fun h ->
    fun s ->
      object (_)
        inherit  ((Elpi.API.Conversion.ctx) h)
        method ctx = in_ctx.Elpi.API.Conversion.get s
        method tctx = in_tctx.Elpi.API.Conversion.get s
      end
let _ = term_ctx
let in_term_ctx ~depth  h c s =
  let ctl = [Elpi.API.PPX.C in_ctx; Elpi.API.PPX.C in_tctx] in
  let (s, gls) = Elpi.API.PPX.readback_context ~depth ctl h c s in
  (s, (term_ctx h s), gls)
let _ = in_term_ctx
let () = declaration := ((!declaration) @ [elpi_term])
[@@@end]

open Elpi.API

let term : 'c. (term, #term_ctx as 'c) Conversion.t = term
let in_term_ctx : term_ctx Conversion.ctx_readback  = in_term_ctx

let builtin = let open BuiltIn in
  declare ~file_name:(Sys.argv.(1)) !declaration

let main () =
  let _elpi, _ = Setup.init ~builtins:[builtin] ~basedir:"." [] in
  BuiltIn.document_file builtin;
  exit 0
;;

main ()
