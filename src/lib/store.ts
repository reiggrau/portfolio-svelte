import { writable } from 'svelte/store';

// Darkmode
export const darkmode = writable(false);

// Scene focus
export const view = writable('earth'); // 'earth' | 'moon' | 'mars'

// HD mode
export const HD = writable(false);

// Loading Overlay
export const overlay = writable(true);

// Sound - activates after 'continue' click
export const sound = writable(false);
