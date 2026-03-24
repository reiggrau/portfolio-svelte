export const sectionViews = {
	Home: 'earth',
	About: 'moon',
	Skills: 'mars',
	Projects: 'venus',
	Contact: 'mercury'
} as const;

export type Section = keyof typeof sectionViews;
export type View = (typeof sectionViews)[Section];

export const viewSections = Object.fromEntries(
	Object.entries(sectionViews).map(([k, v]) => [v, k])
) as Record<View, Section>;

export const viewOrder: View[] = Object.values(sectionViews);
