import { writable } from 'svelte/store'; // Global state management for the application
import type { View } from '../../types';

// Textures
export const texturesReady = writable(false);

// Texture load order
export const loadingPhase = writable<'earth' | 'wait' | 'remaining'>('earth');

// Darkmode
export const darkmode = writable(false);

// Scene focus
export const view = writable('earth' as View); // 'earth' | 'moon' | 'mars'

// HD mode
export const HD = writable(false);

// Loading Overlay
export const overlay = writable(true);

// Sound - activates after 'continue' click
export const sound = writable(false);
