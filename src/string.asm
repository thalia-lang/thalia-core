;; Copyright (C) 2025 Stan Vlad <vstan02@protonmail.com>
;;
;; This file is part of Thalia.
;;
;; Thalia is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

global core__string__size

section .text
  core__string__size:
    enter 0, 0
    push ebx
    xor eax, eax
    mov ebx, [ebp + 0x8]
  .ll0:
    cmp byte [ebx + eax], 0x0
    je .ll1
    inc eax
    jmp .ll0
  .ll1:
    pop ebx
    leave
    ret

