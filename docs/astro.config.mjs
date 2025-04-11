// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'Docs',
			favicon: 'favicon.png',
			social: {
				github: 'https://github.com/SoftonixMobile',
			},
			sidebar: [
				{
					label: '📦 Project Setup',
					items: [
						{ label: 'Create a project', slug: 'project_setup/create_project' },
					],
				},
				{
					label: '🌐 Internationalization',
					items: [
						{ label: 'Localization', slug: 'internationalization/localization' },
					],
				}
			],
		}),
	],
});
