import { writable } from 'svelte/store';

// Darkmode
export const darkmode = writable(false as boolean);

// Scene focus
export const view = writable('earth'); // 'earth' | 'moon'
