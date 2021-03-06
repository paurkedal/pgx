(* PG'OCaml is a set of OCaml bindings for the PostgreSQL database.
 *
 * PG'OCaml - type safe interface to PostgreSQL.
 * Copyright (C) 2005-2009 Richard Jones and other authors.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this library; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
*)
module type IO = Io_intf.S

(* FIXME: I can't figure out how to not duplicate these types from types.ml *)
type oid = int32 [@@deriving sexp]

type param = Pgx_value.t [@@deriving sexp_of] (** None is NULL. *)
type result = Pgx_value.t [@@deriving sexp_of] (** None is NULL. *)
type row = Pgx_value.t list [@@deriving sexp_of] (** One row is a list of fields. *)

type params_description = oid list [@@deriving sexp]

exception PostgreSQL_Error of string * Error_response.t [@@deriving sexp]
(** For errors generated by the PostgreSQL database back-end.  The
 * first argument is a printable error message.  The second argument
 * is the complete set of error fields returned from the back-end.
 * See [http://www.postgresql.org/docs/8.1/static/protocol-error-fields.html] *)

module Access = Access
module Isolation = Isolation
module Error_response = Error_response
module Result_desc = Result_desc
module Value = Pgx_value

module type S = Pgx_intf.S

module Make : functor (Thread : IO) -> S with type 'a monad = 'a Thread.t
